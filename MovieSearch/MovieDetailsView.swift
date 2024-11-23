//
//  MovieDetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var favorites: Favorites

    var movie: Movie
    
    var body: some View {
        ScrollView {
            VStack {
                Text(movie.title)
                    .font(.title.bold())
                    .padding(.bottom, 5)
                
                if let posterPath = movie.poster_path {
                    let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
                    
                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 150)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        case .success(let image):
                            image
                                .resizable()
                               .aspectRatio(contentMode: .fit)
                               .cornerRadius(5)
                               .padding()
                        case .failure:
                            Text("Failed to load image")
                                .frame(width: 100, height: 150)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        @unknown default:
                            EmptyView()
                        }
                    }
                } else {
                    Text("No Image Available")
                        .frame(width: 100, height: 150)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }
        
                VStack(alignment: .leading) {
        
                    Text(movie.overview)
 
                    Text("Rating \(String(movie.vote_average ?? 0))/\(String(movie.vote_count ?? 0))")
                        .font(.title.bold())
                    
                    if let rating = movie.vote_average {
                        RatingView(rating: .constant(rating))
                            .font(.headline)
                    }
                    
                    Text(movie.release_date  ?? "Unknown Release Date")
                        .font(.title)
                    
                    HStack {
                        Button(favorites.contains(movie) ? "Remove from Favorites" : "Add to Favorites") {
                            if favorites.contains(movie) {
                                favorites.remove(movie)
                            } else {
                                favorites.add(movie)
                            }
                        }
                        
                        if favorites.contains(movie) {
                            Spacer()
                            Image(systemName: "heart.fill")
                            .accessibilityLabel("This is a favorite resort")
                                .foregroundStyle(.red)
                                .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
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
    let wickedMovie = Movie(
        id: 402431,
           title: "Wicked",
           original_title: "Wicked",
           original_language: "en",
           overview: """
               Elphaba, an ostracized but defiant girl born with green skin, and Galinda, 
               a privileged aristocrat born popular, become extremely unlikely friends 
               in the magical Land of Oz. As the two girls struggle with their opposing 
               personalities, their friendship is tested as both begin to fulfil their destinies 
               as Glinda the Good and The Wicked Witch of the West.
               """,
           poster_path: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
           backdrop_path: "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
           genre_ids: [18, 14, 10749],
           release_date: "2024-11-20",
           popularity: 927.236,
           vote_average: 7.5,
           vote_count: 30,
           adult: false,
           video: false
    )
    
    MovieDetailsView(movie: wickedMovie)
        .environmentObject(Favorites())
}
