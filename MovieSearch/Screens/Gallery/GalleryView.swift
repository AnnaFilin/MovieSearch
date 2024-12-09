//
//  GalleryView.swift
//  MovieSearch
//
//  Created by Anna Filin on 06/12/2024.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject private var favorites: Persistence
    let trendingMovies: [Movie]?
    let popularMovies: [Movie]?
    let topRatedMovies: [Movie]?
    let searchMovies: [Movie]?
    let genres: [Genre]
    @Binding var selectedTab: Int

        var body: some View {
            NavigationStack {
                BaseView(title: "") {
                        ScrollView {
                            VStack(alignment: .leading, spacing: AppSpacing.vertical ) {
                                if let searchMovies = searchMovies, !searchMovies.isEmpty {
                                    Text("Search results")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)

//                                    HorizontalScroll(items: Array(searchMovies)) { movie in
//                                        NavigationLink(value: movie) {
//                                            FavoriteMovieCard(movie: movie)
//                                                .frame(width: UIScreen.main.bounds.width - AppSpacing.horizontal)
//                                        }
//                                    }
                                    CarouselView(movies: searchMovies)
                                }
                                
                                if !favorites.favoritedMovies.isEmpty {
                                    Text("Favorites")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)

                                    if let searchMovies = searchMovies, !searchMovies.isEmpty {
                                            HorizontalScroll(items: Array(favorites.favoritedMovies))  { movie in
                                                NavigationLink(value: movie) {
                                                    MovieCard(movie: movie)
                                                }
                                            }
                                        }
                                        else {
                                            HorizontalScroll(items: Array(favorites.favoritedMovies)) { movie in
                                            NavigationLink(value: movie) {
                                                FavoriteMovieCard(movie: movie)
                                                    .frame(width: UIScreen.main.bounds.width - AppSpacing.horizontal)
                                            }
                                        }
                                    }
                                }
        
                                
                                if let topRatedMovies = topRatedMovies, !topRatedMovies.isEmpty {
                                    
                                    Text("Top Rated")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                    
                                    HorizontalScroll(items: topRatedMovies)  { movie in
                                        NavigationLink(value: movie) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                                
                                Text("Genres")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .opacity(0.65)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                
                                HorizontalScroll(items: genres) { genre in
                                    GenreView(genre: genre)
                                        .opacity(0.7)
                                }
                                
                                if let popularMovies = popularMovies, !popularMovies.isEmpty {
                                    
                                    HStack() {
                                        Text("Popular")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .opacity(0.65)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(nil)

                                        Spacer()
                                        Button(action: {
                                            
                                        }) {
                                            Text("See all")
                                                .font(.headline)
                                        }   
                                    }
                                    
                                    HorizontalScroll(items: popularMovies)  { movie in
                                        NavigationLink(value: movie) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                                
                                if let trendingMovies = trendingMovies, !trendingMovies.isEmpty {
                                    
                                    Text("Trendind Movies")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                    
                                    HorizontalScroll(items: trendingMovies)  { movie in
                                        NavigationLink(value: movie) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                            }
                            .padding(.top,AppSpacing.vertical)
                            .padding(.horizontal, AppSpacing.horizontal)
                        }
                }
                .navigationDestination(for: Movie.self) { selection in
                    MovieDetailsView(movie: selection)
                }
            }
            .tint(.theme)
        }
    }



#Preview {
    GalleryView(trendingMovies: [.example], popularMovies: [.example],topRatedMovies: [.example], searchMovies: [.example], genres: [.example], selectedTab: .constant(2))
                .environmentObject(Persistence())
}
