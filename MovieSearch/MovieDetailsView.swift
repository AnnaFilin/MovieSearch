//
//  MovieDetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    var movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                Text(movie.title)
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                AsyncImage(url: URL(string: movie.poster_path), scale: 1) { image in
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(5)
                    .padding()
                
            } placeholder: {
                ProgressView()
            }

                VStack(alignment: .leading) {
        
                    Text(movie.overview)
 
                    Text("Rating \(String(movie.vote_average))/\(String(movie.vote_count))")
                        .font(.title.bold())
                        
                    Text(movie.release_date)
                        .font(.title)
                }
                .padding(.horizontal)
            }
            .padding(.bottom)
            .foregroundStyle(.white)
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
        .background(Color(red: 0.15, green: 0.16, blue: 0.12))
    }
}

#Preview {
    let movie = Movie(adult: false, backdrop_path: "https://image.tmdb.org/t/p/original/5IIFJxwRzmkhczQidIhpoaolpZY.jpg", genre_ids: [28, 53, 80], id: 976734, original_language: "en", original_title: "Canary Black", overview: "Top level CIA agent Avery Graves is blackmailed by terrorists into betraying her own country to save her kidnapped husband. Cut off from her team, she turns to her underworld contacts to survive and help locate the coveted intelligence that the kidnappers want.", popularity: 631.691, poster_path: "https://image.tmdb.org/t/p/original/hhiR6uUbTYYvKoACkdAIQPS5c6f.jpg", release_date: "2024-10-10", title: "Canary Black", video: false, vote_average: 6.3, vote_count: 241)
    
    MovieDetailsView(movie: movie)
}
