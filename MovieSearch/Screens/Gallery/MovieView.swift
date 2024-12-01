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
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                        .lineLimit(2)
                    
                    Text("Rating \(String(movie.voteAverage))/\(String(movie.voteCount ?? 0))")
                        .font(.subheadline)
                    
                    Text(movie.releaseDate ?? "Release date unknown")
                        .font(.subheadline)
                }
                .padding(.top)
                .padding(.leading, 8)
                
                Spacer()
                
                Button(action: {
                    if favorites.contains(movie) {
                        favorites.remove(movie)
                    } else {
                        favorites.add(movie)
                    }
                }) {
                    Image(systemName: favorites.contains(movie) ? "heart.fill" : "heart")
                        .foregroundColor(.orange)
                        .font(.title2)
                        .fontWeight(.semibold)
                        .accessibilityLabel(favorites.contains(movie) ? "Remove from Favorites" : "Add to Favorites")
                }
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

