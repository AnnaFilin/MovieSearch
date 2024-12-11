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
                                    
                                    Text("Search")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .padding(.horizontal, AppSpacing.horizontal)
                                        .id("SearchResults")
                                    
                                    HorizontalScroll(items: viewModel.searchMovies,  horizontalInset: AppSpacing.horizontal)  { movie in
                                        NavigationLink(value: movie) {
                                            MovieCard(movie: movie)
                                        }
                                    }
                                }
                            }
                            
                            if !viewModel.topRatedMovies.isEmpty {
                                HStack {
                                    Text("Top Rated")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        
//                                    Spacer()
//                                    Button(action: {     
//                                    }) {
//                                        Text("See all")
//                                            .font(.headline)
//                                    }
                                }
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
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .padding(.horizontal, AppSpacing.horizontal)
                            
                            HorizontalScroll(items: genres, horizontalInset: AppSpacing.horizontal ) { genre in
                                GenreView(genre: genre)
                                    .opacity(0.7)
                            }
                            
                            if !viewModel.popularMovies.isEmpty {
                                HStack {
                                    Text("Popular")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        
//                                    Spacer()
//                                    Button(action: {
//                                        
//                                    }) {
//                                        Text("See all")
//                                            .font(.headline)
//                                          
//                                    }
                                }
                                .padding(.horizontal, AppSpacing.horizontal)
                                
                                HorizontalScroll(items: viewModel.popularMovies,  horizontalInset: AppSpacing.horizontal)  { movie in
                                    NavigationLink(value: movie) {
                                        MovieCard(movie: movie)
                                    }
                                }
                            }
                            if !viewModel.trendingMovies.isEmpty {
                                
                                HStack {
                                    Text("Trending")
                                        .font(.title2)
                                        .fontWeight(.bold)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        
//                                    Spacer()
//                                    Button(action: {
//                                        
//                                    }) {
//                                        Text("See all")
//                                            .font(.headline)
//                                    }
                                }
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
