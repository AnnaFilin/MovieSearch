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
    @Binding var path: [AppNavigation]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8){
//            HStack {
//                RatingView(voteAverage: movieDetails.voteAverage, voteCount: movieDetails.voteCount)
//            }
            
            HStack(spacing: 8) {
                Image(systemName: "clock")
                    .foregroundColor(.orange)
                Text(formatMovieDuration(minutes: movieDetails.runtime))
                    .font(.callout)
                    .opacity(0.5)
                
                Spacer()
                
                FavoritesButtonView(movie: movie, path: $path)
                    .padding(.horizontal, 4)
                
            }
        }
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


#Preview {
    
    DetailsView(movieDetails: .example, movie: .example, path: .constant([]))
        .environmentObject(Persistence())
}
