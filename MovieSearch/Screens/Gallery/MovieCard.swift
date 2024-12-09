//
//  MovieCard.swift
//  MovieSearch
//
//  Created by Anna Filin on 06/12/2024.
//

import SwiftUI

struct MovieCard: View {
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            if let posterPath = movie.posterPath {
                ZStack(alignment: .topTrailing) {
                    ImageView(url: posterPath, width: 190, height: 270, opacity: 0.8, fillContentMode: true)
                        .clipped()
                        .shadow(radius: 2)
                        .cornerRadius(8)

                    FavoritesButtonView(movie: movie)
                        .padding()
                }
            }
            
            HStack {
                
                Text(movie.title)
                    .font(.subheadline)
                    .fontWeight(.semibold)
                    .opacity(0.7)
                    .lineLimit(nil)
                    .multilineTextAlignment(.leading)
                    .frame(maxWidth: 190, alignment: .leading)
                
                RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
            }
            
            if let releaseDate = movie.releaseDate {
                ReleaseDateView(date: releaseDate)
            }
        }
        .frame(width: 190)
    }
    
    
    
}

#Preview {
    MovieCard(movie: .example)
        .environmentObject(Persistence())
}
