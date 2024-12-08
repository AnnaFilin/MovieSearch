//
//  GalleryView.swift
//  MovieSearch
//
//  Created by Anna Filin on 06/12/2024.
//

import SwiftUI

struct GalleryView: View {
        let trendingMovies: [Movie]?
    let popularMovies: [Movie]?
    let topRatedMovies: [Movie]?
    let genres: [Genre]
//        let title: String
        @Binding var selectedTab: Int

        var body: some View {
            NavigationStack {
                BaseView(title: "") {
                        ScrollView {
                            VStack(alignment: .leading, spacing: AppSpacing.vertical * 2) {
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
//                                ForEach(movies, id: \.self.id) { movie in
//                                    NavigationLink(value: movie) {
//                                        MovieView(movie: movie)
//                                    }
//                                }
                            }
                            .padding(.top,AppSpacing.vertical)
                            .padding(.horizontal, AppSpacing.horizontal)
                        }
//                    } else {
//                       EmptyStateView(selectedTab: $selectedTab)
//                    }
                }
                .navigationDestination(for: Movie.self) { selection in
                    MovieDetailsView(movie: selection)
                }
            }
            .tint(.theme)
        }
    }



#Preview {
    GalleryView(trendingMovies: [.example], popularMovies: [.example],topRatedMovies: [.example], genres: [.example], selectedTab: .constant(2))
                .environmentObject(Persistence())
}
