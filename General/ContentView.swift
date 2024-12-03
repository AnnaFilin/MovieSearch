//
//  ContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @StateObject private var favorites = Persistence()
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TabContentView(movies: viewModel.trendingMovies, title: "Trending", selectedTab: $selectedTab)
                .searchable(text: $viewModel.searchText, prompt: "Search movie")
                .onAppear {
                    viewModel.searchText = ""
                    if viewModel.trendingMovies.isEmpty {
                        Task {
                            await viewModel.loadSavedMovies()
//                            await viewModel.fetchMovies()
                        }
                    }
                }
                .onChange(of: viewModel.searchText) {
                    Task {
                        selectedTab = 2
                        await viewModel.searchMovies(query: viewModel.searchText)
                    }
                 }
                .tabItem {
                    Label("Trending", systemImage: "film")
                }
                .tag(0)
            
                TabContentView(movies: viewModel.movies, title: "Favorites", selectedTab: $selectedTab)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(1)
                
                TabContentView(movies: viewModel.searchMovies, title: "Search", selectedTab: $selectedTab)
                   .searchable(text: $viewModel.searchText, prompt: "Search movie")
                   .onChange(of: viewModel.searchText) {
                       Task {
                           
                           await viewModel.searchMovies(query: viewModel.searchText)
                       }
                    }
                   .tabItem {
                       Label("Search", systemImage: "magnifyingglass")
                   }
                   .tag(2)
            }
        .accentColor(.shadow)
        .preferredColorScheme(.dark)
        .environmentObject(favorites)
    }
}

#Preview {
    ContentView()
        .environmentObject(Persistence())
}
