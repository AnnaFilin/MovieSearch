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
    @StateObject private var viewModel = ViewModel(movieService: MovieService())
    @State private var selectedTab: Int = 0
    @State private var path: [AppNavigation] = []
    
    var body: some View {
        GeometryReader { geometry in 
            let screenWidth = geometry.size.width
            
            TabView(selection: $selectedTab) {
                NavigationStack(path: $path) {
                    
                    GalleryView(selectedTab: $selectedTab, path: $path, screenWidth: screenWidth)
                    
                        .onAppear {
                            viewModel.searchText = ""
                            viewModel.searchMovies = []
                            Task {
                                await viewModel.prepareData()
                            }
                        }
                    
                        .environmentObject(viewModel)
                        .onChange(of: viewModel.searchMovies) { oldMovies, newMovies in
                            if !newMovies.isEmpty {
                                path.append(.tabContent(movies: newMovies, title: !viewModel.searchText.isEmpty ? viewModel.searchText.capitalized : viewModel.searchGenre.capitalized))
                            }
                        }
                    
                        .navigationDestination(for: AppNavigation.self) { navigation in
                            switch navigation {
                            case .tabContent(let movies, let title):
                                MoviesGridView(movies: movies, title: title, path: $path, screenWidth: screenWidth)
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
                        if case .movieDetails(let movie) = navigation {
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
        .environmentObject(ViewModel(movieService: MovieService()))
        .environmentObject(Persistence())
}
