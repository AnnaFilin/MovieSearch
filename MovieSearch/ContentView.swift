//
//  ContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var viewModel = ViewModel()
    @StateObject private var favorites = Favorites()
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            TabContentView(movies: viewModel.trendingMovies, title: "Trending")
                .searchable(text: $viewModel.searchText, prompt: "Search movie")
                .onAppear {
                    viewModel.searchText = ""
                    if viewModel.trendingMovies.isEmpty {
                        Task {
                            await viewModel.loadSavedMovies()
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
//                        .shadow(color: .orange, radius: 1)
                }
                .tag(0)
            
                TabContentView(movies: viewModel.movies, title: "Favorites")
                    .tabItem {
                        Label("Favorites", systemImage: "star")
//                            .shadow(color: .orange, radius: 1)
                    }
                    .tag(1)
                
                TabContentView(movies: viewModel.searchMovies, title: "Search")
                   .searchable(text: $viewModel.searchText, prompt: "Search movie")
                   .onChange(of: viewModel.searchText) {
                       Task {
                           
                           await viewModel.searchMovies(query: viewModel.searchText)
                       }
                    }
                   .tabItem {
                       Label("Search", systemImage: "magnifyingglass")
//                           .shadow(color: .orange, radius: 1)
                   }
                   .tag(2)
            }
        .preferredColorScheme(.dark)
        .environmentObject(favorites)
    }
}

#Preview {
    ContentView()
}
