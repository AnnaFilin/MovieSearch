//
//  MovieView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieView: View {
    var movie: Movie
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 140)
                .opacity(0.1)
                .cornerRadius(5)
                .padding()
                .shadow(color: .orange, radius: 10)
            
                AsyncImage(url: URL(string: movie.poster_path), scale: 2) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(maxWidth: .infinity, maxHeight: 140)
                        .opacity(0.5)
                        .cornerRadius(5)
                        .padding()
                    
                } placeholder: {
                    ProgressView()
                }

            
            HStack(alignment: .top) {
                AsyncImage(url: URL(string: movie.poster_path), scale: 2) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 90)
                        .cornerRadius(5)
                    
                } placeholder: {
                    ProgressView()
                }

                           
                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Rating \(String(movie.vote_average))/\(String(movie.vote_count))")
                        .font(.headline)
                    Text(movie.release_date)
                        .font(.subheadline)
                }
                .foregroundStyle(.white)
                .padding(.top)
                
                Spacer()
            }
            .padding()
        }
       
        
    }
}

#Preview {
    let movie = Movie(adult: false, backdrop_path: "https://image.tmdb.org/t/p/original/5IIFJxwRzmkhczQidIhpoaolpZY.jpg", genre_ids: [28, 53, 80], id: 976734, original_language: "en", original_title: "Canary Black", overview: "Top level CIA agent Avery Graves is blackmailed by terrorists into betraying her own country to save her kidnapped husband. Cut off from her team, she turns to her underworld contacts to survive and help locate the coveted intelligence that the kidnappers want.", popularity: 631.691, poster_path: "https://image.tmdb.org/t/p/original/hhiR6uUbTYYvKoACkdAIQPS5c6f.jpg", release_date: "2024-10-10", title: "Canary Black", video: false, vote_average: 6.3, vote_count: 241)
    MovieView(movie: movie)
}

