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
                            ForEach(Array(viewModel.dataItems.enumerated()), id: \.offset) { index, dataItem in
                                switch dataItem.type {
                                case .movieCard:
                                    if let movies = dataItem.data as? [Movie] {
                                        MovieSection(movies: movies, title: dataItem.title, path: $path)
                                    }
                                case .tag:
                                    if let genres = dataItem.data as? [Genre] {
                                        //                                                    TagSection(tags: genres)
                                        TagSection(tags: genres, path: $path,title: dataItem.title )
                                    }
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
}


//
//#Preview {
//    GalleryView(genres: [.example], selectedTab: .constant(2), path: .constant([]), screenWidth:UIScreen.main.bounds.width )
//        .environmentObject(ViewModel(movieService: MovieService()))
//        .environmentObject(Persistence())
//}
