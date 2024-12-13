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
            RoundedRectangle(cornerRadius: 25)
                .fill(.shadow)
        
            VStack {
                Image(genre.image)
                    .renderingMode(.template)
                    .resizable()
                    .foregroundColor(.white)
                    .opacity(0.8)
                    .frame(width: 90, height: 80)
                Button(genre.name) {
                    Task {
                        await fetchMoviesByGenre()
                    }
                }
                .foregroundStyle(.white)
                .font(.custom("ArialRoundedMTBold", size: 28))
                .offset(y: -15)
            }
            
        }
        .frame(width: 200, height: 130)
    }
    
    func fetchMoviesByGenre() async {
        
        print("search by genre \(genre.name), id: \(genre.id)")
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
    //        .environmentObject(<#T##object: ObservableObject##ObservableObject#>)
}
