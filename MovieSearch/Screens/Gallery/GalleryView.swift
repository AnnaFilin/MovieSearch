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
    @Binding var path: [AppNavigation]
    let screenWidth: CGFloat
    
    var body: some View {
        ScrollViewReader { proxy in
            BaseView(title: "") {
                Color.clear
                    .frame(height: 10)
                
                VStack(spacing: 0) {
                    
                    CustomSearchBar(searchText: $viewModel.searchText)
                        .padding(.horizontal, AppSpacing.horizontal)
                        .padding(.bottom, AppSpacing.vertical)
                        .frame(height: 50)
                    
                    
                    ScrollView {
                        VStack(alignment: .leading, spacing: AppSpacing.vertical * 2 ) {
                            
                            if !viewModel.searchMovies.isEmpty {
                                VStack(alignment: .leading, spacing: AppSpacing.vertical) {
                                    
                                    Text("Search")
                                        .font(.system(size: 20, weight: .light, design: .default))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                        .padding(.horizontal, AppSpacing.horizontal)
                                        .id("SearchResults")
                                    
                                    GridView(movies: viewModel.searchMovies, path: $path, width: screenWidth)
                                }
                                .padding(.top, 10)
                            }
                            
                            if !viewModel.topRatedMovies.isEmpty {
                                HStack {
                                    Text("Top Rated")
                                        .font(.system(size: 20, weight: .light, design: .default))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                    
                                    Spacer()
                                    
                                    Button("See all") {
                                        path.append(.tabContent(movies: viewModel.topRatedMovies, title: "Top Rated"))
                                    }
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(.shadow)
                                    .padding(.trailing, 12) 
                                }
                                .padding(.horizontal, AppSpacing.horizontal)
                                .shadow(color: .lilac.opacity(0.4), radius: 20, x: 0, y: 10)
                                
                                HorizontalScroll(items: viewModel.topRatedMovies, horizontalInset: AppSpacing.horizontal)  { movie in
                                    
                                    Button {
                                        path.append(.movieDetails(movie: movie))
                                    } label: {
                                        MovieCard(movie: movie)
                                    }
                                }
                                .padding(.bottom, AppSpacing.vertical)
                                .shadow(color: .lilac.opacity(0.2), radius: 20, x: 5, y: 10)
                            }
                            
                            Text("Genres")
                                .font(.system(size: 20, weight: .light, design: .default))
                                .foregroundColor(.white)
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .padding(.horizontal, AppSpacing.horizontal)
                            
                            HorizontalScroll(items: genres, horizontalInset: AppSpacing.horizontal ) { genre in
                                GenreView(genre: genre)
                                    .opacity(0.7)
                            }
                            .padding(.bottom, AppSpacing.vertical)
                            .shadow(color: .lilac.opacity(0.2), radius: 20, x: 5, y: 10)
                            
                            if !viewModel.popularMovies.isEmpty {
                                HStack {
                                    Text("Popular")
                                        .font(.system(size: 20, weight: .light, design: .default))
                                        .foregroundColor(.white)
                                        .multilineTextAlignment(.leading)
                                        .lineLimit(nil)
                                    
                                    Spacer()
                                    
                                    Button("See all") {
                                        path.append(.tabContent(movies: viewModel.popularMovies, title: "Popular"))
                                    }
                                    .font(.system(size: 16, weight: .medium, design: .default))
                                    .foregroundColor(.shadow)
                                    .padding(.trailing, 12) 
                                }
                                .padding(.horizontal, AppSpacing.horizontal)
                                
                                HorizontalScroll(items: viewModel.popularMovies,  horizontalInset: AppSpacing.horizontal)  { movie in
                                    
                                    Button {
                                        path.append(.movieDetails(movie: movie))
                                    } label: {
                                        MovieCard(movie: movie)
                                    }
                                }
                                .shadow(color: .lilac.opacity(0.2), radius: 20, x: 5, y: 10)
                            }
                        }
                    }
                    .padding(.top, AppSpacing.vertical*2)
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
    }
}



#Preview {
    GalleryView(genres: [.example], selectedTab: .constant(2), path: .constant([]), screenWidth:UIScreen.main.bounds.width )
        .environmentObject(ViewModel())
        .environmentObject(Persistence())
}
