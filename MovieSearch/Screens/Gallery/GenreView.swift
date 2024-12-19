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
                        await viewModel.fetchMoviesByGenre(genre: genre)
                    }
                }
                .foregroundStyle(.white)
                .font(.headline)
                .opacity(1.0)
            }
            .padding()
        }
    }
}

#Preview {
    GenreView(genre: .example)
            .environmentObject(ViewModel(movieService: MovieService()))
}
