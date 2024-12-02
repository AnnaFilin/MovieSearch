//
//  MovieView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieView: View {
    @EnvironmentObject var favorites: Persistence
    
    var movie: Movie

//    var formattedReleaseDate: String {
//        let inputDateFormatter = DateFormatter()
//        inputDateFormatter.dateFormat = "yyyy-MM-dd"
//        let outputDateFormatter = DateFormatter()
//        outputDateFormatter.dateFormat = "dd MMM yy"
//
//        if let date = inputDateFormatter.date(from: movie.releaseDate ?? "") {
//            return outputDateFormatter.string(from: date)
//        } else {
//            return "Release date unknown"
//        }
//    }
    
    var body: some View {
        ZStack {

            if let posterPath = movie.posterPath {
                GeometryReader { geometry in
                    ImageView(url: posterPath, width: geometry.size.width , height: 150, opacity: 0.5, fillContentMode: true)
                        .frame(width: geometry.size.width - 10)
                        .position(x: geometry.size.width / 2, y: 75)
                }
            }
            
            HStack(alignment: .top, spacing: 0) {
                
                if let posterPath = movie.posterPath {
                ImageView(url: posterPath, width: 90, height: 150, opacity: 1.0, fillContentMode: true)
                        .frame(width: 90, height: 150)
                        .clipped()
                        .cornerRadius(5)
                        .shadow(color: .shadow, radius: 1)
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                        .lineLimit(2)
                    
                    RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                        .font(.subheadline)
                    
                    if let date = movie.releaseDate {
                        ReleaseDateView(date: date)
                    }
                    
                }
                .padding(.top)
                .padding(.leading, 8)
                
                Spacer()
                
                FavoritesButtonView(movie: movie)
                    .padding()
            }
        }
        .frame(maxWidth: .infinity, maxHeight: 150)
        .background(
            Color(red: 0.15, green: 0.16, blue: 0.12)
                .cornerRadius(5)
                .shadow(color: .orange, radius: 3)
        )
        .foregroundStyle(.theme)
        .padding(.horizontal)
        .padding(.bottom)
    }
}

#Preview {
    MovieView( movie: .example)
        .environmentObject(Persistence())
}

