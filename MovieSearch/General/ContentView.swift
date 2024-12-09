//
//  ContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    let genres: [Genre] = Bundle.main.decode("Genres.json")
    @StateObject private var viewModel = ViewModel()
//    @StateObject private var favorites = Persistence()
    @State private var selectedTab: Int = 0

    var body: some View {
        TabView(selection: $selectedTab) {
            GalleryView(trendingMovies: viewModel.trendingMovies, popularMovies: viewModel.popularMovies, topRatedMovies: viewModel.topRatedMovies, searchMovies: viewModel.searchMovies, genres: genres, selectedTab: $selectedTab)
                .onAppear {
                    viewModel.searchText = ""
                    if viewModel.trendingMovies.isEmpty {
                        Task {
                            await viewModel.loadSavedMovies()
                            await viewModel.fetchPopularMovies()
                            await viewModel.fetchTopRatedMovies()
                        }
                    }
                }
                .onChange(of: viewModel.searchText) {
                   Task {
//                       selectedTab = 2
                       await viewModel.searchMovies(query: viewModel.searchText)
                   }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search movie")
                .tabItem {
                    Label("All movies", systemImage: "film")
                }
                .tag(0)
            
            
//            TabContentView(movies: viewModel.trendingMovies, title: "Trending", selectedTab: $selectedTab)
//                .searchable(text: $viewModel.searchText, prompt: "Search movie")
//                .onAppear {
//                    print("All environment variables: \(ProcessInfo.processInfo.environment)")
//                    viewModel.searchText = ""
//                    if viewModel.trendingMovies.isEmpty {
//                        Task {
//                            await viewModel.loadSavedMovies()
////                            await viewModel.fetchMovies()
//                        }
//                    }
//                }
//                .onChange(of: viewModel.searchText) {
//                    Task {
//                        selectedTab = 2
//                        await viewModel.searchMovies(query: viewModel.searchText)
//                    }
//                 }
//                .tabItem {
//                    Label("Trending", systemImage: "film")
//                }
//                .tag(0)
//            
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
    
        .accentColor(.theme)
        .preferredColorScheme(.dark)
//        .environmentObject(favorites)
    }
}

#Preview {
    ContentView()
        .environmentObject(Persistence())
}
