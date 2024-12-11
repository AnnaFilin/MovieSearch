//
//  FavoriteMovieCard.swift
//  MovieSearch
//
//  Created by Anna Filin on 08/12/2024.
//

import SwiftUI

struct FavoriteMovieCard: View {
    let movie: Movie
    
    var body: some View {

        GeometryReader { geometry in
        if let posterPath = movie.posterPath {
            ImageView(url: posterPath, width: geometry.size.width - AppSpacing.horizontal, height:  geometry.size.width * 1.4 + 60, opacity: 0.9, fillContentMode: true)
                .frame(width: geometry.size.width - AppSpacing.horizontal, height: geometry.size.width * 1.4)
                .clipped()
                .overlay(
                    Rectangle()
                        .fill(LinearGradient(
                            gradient: Gradient(colors: [Color.background.opacity(0.01), Color.background.opacity(0.3)]),
                            startPoint: .center,
                            endPoint: .bottom
                        ))
                        .frame(height: geometry.size.height / 2),
                    alignment: .bottom
                )
                .cornerRadius(16)
                .shadow(radius: 4)
            }
        }
        .frame(width: UIScreen.main.bounds.width - AppSpacing.horizontal, height: UIScreen.main.bounds.width * 1.4)
    }
}

#Preview {
    FavoriteMovieCard(movie: .example)
}
