//
//  ContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

enum AppNavigation: Hashable {
    case tabContent(movies: [Movie], title: String)
    case movieDetails(movie: Movie)
}

struct ContentView: View {
    @EnvironmentObject private var favorites: Persistence
    let genres: [Genre] = Bundle.main.decode("Genres.json")
    @StateObject private var viewModel = ViewModel()
    @State private var selectedTab: Int = 0
    @State private var path: [AppNavigation] = []
    
    var body: some View {
        GeometryReader { geometry in 
            let screenWidth = geometry.size.width
            
            TabView(selection: $selectedTab) {
                NavigationStack(path: $path) {
                    GalleryView( genres: genres, selectedTab: $selectedTab, path: $path, screenWidth: screenWidth)
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
                        .environmentObject(viewModel)
                        .onChange(of: viewModel.searchText) {
                            Task {
                                await viewModel.searchMovies(query: viewModel.searchText)
                            }
                        }
                        .searchable(text: $viewModel.searchText, prompt: "Search...")
                        .navigationDestination(for: AppNavigation.self) { navigation in
                            switch navigation {
                            case .tabContent(let movies, let title):
                                TabContent(movies: movies, title: title, path: $path, screenWidth: screenWidth)
                            case .movieDetails(let movie):
                                MovieDetailsView(movie: movie)
                            }
                        }
                }
                .tabItem {
                    Label("All movies", systemImage: "film")
                }
                .tag(0)
                
                NavigationStack(path: $path) {
                    TabContentView(
                        title: "Favorites", selectedTab: $selectedTab, path: $path, screenWidth: screenWidth)
                    .navigationDestination(for: AppNavigation.self) { navigation in
                        switch navigation {
                        case .tabContent(let movies, let title):
                            TabContent(movies: movies, title: title, path: $path, screenWidth: screenWidth)
                        case .movieDetails(let movie):
                            MovieDetailsView(movie: movie)
                        }
                    }
                }
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
                .tag(1)
            }
            .accentColor(.theme)
            .preferredColorScheme(.dark)
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(Persistence())
}
