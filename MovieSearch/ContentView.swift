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
            NavigationStack {
                LayoutView(title: "Trending", showSearch: true) {
                        ScrollView {
                            ForEach(viewModel.movies, id: \.self.id) { movie in
                                NavigationLink(value: movie) {
                                    MovieView(movie: movie)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Movie.self) { selection in
                        MovieDetailsView(movie: selection)
                    }
                }
                .searchable(text: $viewModel.searchText, prompt: "Search movie")
                .onAppear {
                    if viewModel.movies.isEmpty {
                        Task {
                            await viewModel.loadSavedMovies()
                        }
                    }
                }
                .tabItem {
                    Label("Trending", systemImage: "person.3")
                }
                .tag(0)
            
                NavigationStack {
                    LayoutView(title: "Favorites", showSearch: false) {
                        ScrollView {
                            ForEach(viewModel.movies, id: \.self.id) { movie in
                                NavigationLink(value: movie) {
                                    MovieView(movie: movie)
                                }
                            }
                        }
                    }
                    .navigationDestination(for: Movie.self) { selection in
                        MovieDetailsView(movie: selection)
                    }
                }
                .tabItem {
                    Label("Favorites", systemImage: "checkmark.circle")
                }
                .tag(1)
                
                NavigationStack {
                    LayoutView(title: "Search", showSearch: true) {
                            ScrollView {
                                ForEach(viewModel.searchMovies, id: \.self.id) { movie in
                                    NavigationLink(value: movie) {
                                        MovieView(movie: movie)
                                    }
                                }
                            }
                        }
                    .navigationDestination(for: Movie.self) { selection in
                        MovieDetailsView(movie: selection)
                    }
                }
               .searchable(text: $viewModel.searchText, prompt: "Search movie")
               .onChange(of: viewModel.searchText) {
                   Task {
                       await viewModel.searchMovies(query: viewModel.searchText)
                   }
                }
               .tabItem {
                   Label("Search", systemImage: "questionmark.diamond")
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
