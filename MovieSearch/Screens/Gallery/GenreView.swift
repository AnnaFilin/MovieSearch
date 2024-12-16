//
//  GenreView.swift
//  MovieSearch
//
//  Created by Anna Filin on 08/12/2024.
//

import SwiftUI

struct GenreView: View {
    let genre: Genre
    @EnvironmentObject var viewModel: ViewModel
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: AppSpacing.cornerRadius)
                .fill(.lilac)
                .opacity(0.6)
            
            VStack {
                Button(genre.name) {
                    print("Button tapped for genre: \(genre.name)")
                    Task {
                        await fetchMoviesByGenre()
                    }
                }
                .foregroundStyle(.white)
                .font(.headline)
                .opacity(1.0)
            }
            .padding()
        }
    }
    
    func fetchMoviesByGenre() async {
        
        viewModel.isLoading = true
        viewModel.errorMessage = nil
        
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(Config.apiKey)&with_genres=\(genre.id)") else {
            viewModel.errorMessage = "Invalid URL."
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            
            viewModel.searchMovies = movieResponse.results
            print(movieResponse.results[0])
        } catch {
            viewModel.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
            print(viewModel.errorMessage ?? "Unknown error")
        }
        
        viewModel.isLoading = false
        
    }
}

#Preview {
    GenreView(genre: .example)
            .environmentObject(ViewModel())
}
