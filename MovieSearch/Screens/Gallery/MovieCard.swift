//
//  MovieCard.swift
//  MovieSearch
//
//  Created by Anna Filin on 06/12/2024.
//

import SwiftUI

struct MovieCard: View {
    var movie: Movie
    var width: CGFloat = 190
    var height: CGFloat = 320
    
    var body: some View {
        VStack(alignment: .leading, spacing: AppSpacing.vertical/4) {
            if let posterPath = movie.posterPath {
                ZStack(alignment: .topTrailing) {
                    ImageView(url: posterPath, width: width, height: height - 50, opacity: 0.8, fillContentMode: true)
                        .clipped()
                        .shadow(radius: 2)
                        .cornerRadius(8)

                    FavoritesButtonView(movie: movie)
                        .padding()
                }
            }
            
            HStack {
                
                Text(movie.title)
                    .lineSpacing(0)
                    .font(.subheadline)
                    .fontWeight(.medium)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 190, alignment: .leading)
                
                RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
            }
            
            if let releaseDate = movie.releaseDate {
                ReleaseDateView(date: releaseDate)
            }
        }
        .frame(width: width, height: height)
    }
}

#Preview {
    MovieCard(movie: .example)
        .environmentObject(Persistence())
}
