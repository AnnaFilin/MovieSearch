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
                       await viewModel.searchMovies(query: viewModel.searchText)
                   }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search movie")
//                .frame(height: 60) // Set a fixed height
//                  .background(
//                      RoundedRectangle(cornerRadius: 12)
//                          .fill(Color(UIColor.systemGray6))
//                  )

                .tabItem {
                    Label("All movies", systemImage: "film")
                }
                .tag(0)
            
                TabContentView(movies: viewModel.movies, title: "Favorites", selectedTab: $selectedTab)
                    .tabItem {
                        Label("Favorites", systemImage: "star")
                    }
                    .tag(1)
                
            }
    
        .accentColor(.theme)
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
        .environmentObject(Persistence())
}
