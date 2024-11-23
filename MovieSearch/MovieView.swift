//
//  MovieView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieView: View {
    @EnvironmentObject var favorites: Favorites
    
    var movie: Movie
    
    var body: some View {
        ZStack {
            Rectangle()
                .frame(maxWidth: .infinity, maxHeight: 140)
                .opacity(0.1)
                .cornerRadius(5)
                .padding()
                .shadow(color: .orange, radius: 10)
   
            
            if let posterPath = movie.poster_path {
            let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")

                AsyncImage(url: url) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 100, height: 150)
                    case .success(let image):
                        image
                            .resizable()
                           .aspectRatio(contentMode: .fill)
                           .frame(maxWidth: .infinity, maxHeight: 140)
                           .opacity(0.5)
                           .cornerRadius(5)
                           .padding()
                    case .failure:
                        Text("Failed to load image")
                            .frame(width: 100, height: 150)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    @unknown default:
                        Text("Unknown error")
                            .frame(width: 100, height: 150)
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                    }
                }
            } else {
                Text("No Image Available")
                    .frame(width: 100, height: 150)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            HStack(alignment: .top) {
          
                if let posterPath = movie.poster_path {
                    let url = URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")

                    AsyncImage(url: url) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                                .frame(width: 100, height: 150)
                        case .success(let image):
                            image
                                .resizable()
                                   .aspectRatio(contentMode: .fit)
                                   .frame(width: 90)
                                   .cornerRadius(5)
                        case .failure:
                            Text("Failed to load image")
                                .frame(width: 100, height: 150)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        @unknown default:
                            Text("Unknown error")
                                .frame(width: 100, height: 150)
                                .background(Color.gray.opacity(0.2))
                                .cornerRadius(10)
                        }
                    }
                } else {
                    Text("No Image Available")
                        .frame(width: 100, height: 150)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(10)
                }

                VStack(alignment: .leading) {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    Text("Rating \(String(movie.vote_average ?? 0))/\(String(movie.vote_count ?? 0))")
                        .font(.headline)
                    
                    Text(movie.release_date  ?? "Unknown Release Date")
                        .font(.subheadline)
                    
                    Button(favorites.contains(movie) ? "Remove from Favorites" : "Add to Favorites") {
                        if favorites.contains(movie) {
                            favorites.remove(movie)
                        } else {
                            favorites.add(movie)
                        }
                    }
                    
                   
                }
                .foregroundStyle(.white)
                .padding(.top)
                
                Spacer()
                
                if favorites.contains(movie) {
                    Spacer()
                    Image(systemName: "heart.fill")
                    .accessibilityLabel("This is a favorite resort")
                        .foregroundStyle(.red)
                        .padding()
                }
            }
            .padding()
        }
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
  
    MovieView(movie: wickedMovie)
        .environmentObject(Favorites())
}

