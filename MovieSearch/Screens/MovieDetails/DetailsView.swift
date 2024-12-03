//
//  DetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 26/11/2024.
//

import SwiftUI

struct DetailsView: View {
    @EnvironmentObject var favorites: Persistence

    var movieDetails: MovieDetail
    var movie: Movie
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
            HStack {
                            RatingView(voteAverage: movieDetails.voteAverage, voteCount: movieDetails.voteCount)
                    
                
            }
//            .padding()
            
            HStack(spacing: 8) {
                Image(systemName: "clock")
                    .foregroundColor(.orange)
                Text(formatMovieDuration(minutes: movieDetails.runtime))
                    .font(.callout)
                    .opacity(0.5)
                
                
                Spacer()

                FavoritesButtonView(movie: movie)
                    .padding(.horizontal, 4)
    
//                Image(systemName: movieDetails.adult ? "lock" : "smiley")
//                    .foregroundColor(movieDetails.adult ? .red : .yellow)
            }
//            .padding()

            
//            if let date = movieDetails.releaseDate {
//                                ReleaseDateView(date: date)
//                            }
        }
    }
    
    func formatMovieDuration(minutes: Int) -> String {
        let hours = minutes / 60
        let remainingMinutes = minutes % 60
        
        if hours > 0 {
            return "\(hours)h \(remainingMinutes)m"
        } else {
            return "\(remainingMinutes)m"
        }
    }
   
}

#Preview {
   
    DetailsView(movieDetails: .example, movie: .example)
        .environmentObject(Persistence())
}
