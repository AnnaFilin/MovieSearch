//
//  GalleryView.swift
//  MovieSearch
//
//  Created by Anna Filin on 06/12/2024.
//

import SwiftUI

struct GalleryView: View {
    @EnvironmentObject private var favorites: Persistence
    @EnvironmentObject var viewModel: ViewModel

    let genres: [Genre]
    @Binding var selectedTab: Int

        var body: some View {
            NavigationStack {
                ScrollViewReader { proxy in
                    BaseView(title: "") {
                        ScrollView {
                            VStack(alignment: .leading, spacing: AppSpacing.vertical ) {
                                if !viewModel.searchMovies.isEmpty {
                                    
                                    VStack(alignment: .leading, spacing: AppSpacing.vertical) {
                                       
                                        Text("Search results")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .opacity(0.65)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(nil)
                                            .padding(.horizontal, AppSpacing.horizontal)
                                            .id("SearchResults")
                                     
                                        CarouselView(movies: viewModel.searchMovies, horizontalInset: AppSpacing.horizontal)
                                    }
                                    
                                }
                                
                                if !favorites.favoritedMovies.isEmpty {
                                    Text("Favorites")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .padding(.horizontal, AppSpacing.horizontal)
                                    
                                    if !viewModel.searchMovies.isEmpty {
                                        HorizontalScroll(items: Array(favorites.favoritedMovies),  horizontalInset: AppSpacing.horizontal)  { movie in
                                            NavigationLink(value: movie) {
                                                MovieCard(movie: movie)
                                            }
                                        }
                                    }
                                    else {
                                        HorizontalScroll(items: Array(favorites.favoritedMovies),  horizontalInset: AppSpacing.horizontal) { movie in
                                            NavigationLink(value: movie) {
                                                FavoriteMovieCard(movie: movie)
                                                    .frame(width: UIScreen.main.bounds.width - AppSpacing.horizontal)
                                            }
                                        }
                                    }
                                }
                                
                                
                                if !viewModel.topRatedMovies.isEmpty {
                                    Text("Top Rated")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .padding(.horizontal, AppSpacing.horizontal)
                                    
                                    HorizontalScroll(items: viewModel.topRatedMovies, horizontalInset: AppSpacing.horizontal)  { movie in
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
                                    .padding(.horizontal, AppSpacing.horizontal)
                                
                                HorizontalScroll(items: genres, horizontalInset: AppSpacing.horizontal ) { genre in
                                    GenreView(genre: genre)
                                        .opacity(0.7)
                                }
                                
                                if !viewModel.popularMovies.isEmpty {
                                    HStack() {
                                        Text("Popular")
                                            .font(.title2)
                                            .fontWeight(.bold)
                                            .opacity(0.65)
                                            .multilineTextAlignment(.leading)
                                            .lineLimit(nil)
                                            .padding(.horizontal, AppSpacing.horizontal)
                                        
                                        Spacer()
                                        Button(action: {
                                            
                                        }) {
                                            Text("See all")
                                                .font(.headline)
                                        }
                                    }
                                    
                                    HorizontalScroll(items: viewModel.popularMovies,  horizontalInset: AppSpacing.horizontal)  { movie in
                                        NavigationLink(value: movie) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                                if !viewModel.trendingMovies.isEmpty {
                                    
                                    Text("Trendind Movies")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .opacity(0.65)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .padding(.horizontal, AppSpacing.horizontal)
                                    
                                    HorizontalScroll(items: viewModel.trendingMovies, horizontalInset: AppSpacing.horizontal)  { movie in
                                        NavigationLink(value: movie) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                            }
                        }
                    }
                    .onChange(of: viewModel.searchMovies) {
                        if !viewModel.searchMovies.isEmpty {
                            withAnimation {
                                proxy.scrollTo("SearchResults", anchor: .top)
                            }
                        }
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
    GalleryView(genres: [.example], selectedTab: .constant(2))
        .environmentObject(ViewModel())
                .environmentObject(Persistence())
}
