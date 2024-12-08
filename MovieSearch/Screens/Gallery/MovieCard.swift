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
                ImageView(url: posterPath, width: 190, height: 270, opacity: 0.8, fillContentMode: true)
                    .clipped()
                    .shadow(radius: 2)
                    .cornerRadius(8)
            }
            
            Text(movie.title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .opacity(0.7)
                .lineLimit(nil)
                .multilineTextAlignment(.leading)
                .frame(maxWidth: 190, alignment: .leading)
        
//            RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
            
            if let releaseDate = movie.releaseDate {
                ReleaseDateView(date: releaseDate)
            }
            
//            Text(movie.character)
//                .font(.subheadline)
//                .fontWeight(.medium)
//                .lineLimit(nil)
//                .multilineTextAlignment(.leading)
//                .frame(maxWidth: 100, alignment: .leading)
//                .opacity(0.5)
        }
        .frame(width: 190)
    }
    
    
    
}

#Preview {
    MovieCard(movie: .example)
}
