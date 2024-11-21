//
//  ContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.16, blue: 0.12)
                    .ignoresSafeArea()

                ScrollView {
                    ForEach(viewModel.movies, id: \.self.id) { movie in
                        NavigationLink(value: movie) {
                            MovieView(movie: movie)
                        }
                    }
                 }
            }
            .navigationTitle("Movies Search")
            .navigationDestination(for: Movie.self) { selection in
                MovieDetailsView(movie: selection)
            }
            .searchable(text: $viewModel.searchText, prompt: "Search movie")
            .onChange(of: viewModel.searchText) {
                Task {
                    await viewModel.fetchMovies(query: viewModel.searchText)
                }
            }
            .onAppear {
                Task {
                    await viewModel.loadSavedMovies()
                }
            }
            .preferredColorScheme(.dark)
        }
    }    
}

#Preview {
    ContentView()
}
