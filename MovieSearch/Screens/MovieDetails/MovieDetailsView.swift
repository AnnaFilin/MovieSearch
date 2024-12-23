//
//  MovieDetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct CastResponse: Codable {
    let id: Int
    let cast: [CastMember]
}

struct MovieImagesResponse: Codable {
    let backdrops: [MovieImage]
        let id: Int
            let logos, posters: [MovieImage]
}

struct MovieDetailsView: View {
    @EnvironmentObject var favorites: Persistence
    @EnvironmentObject var viewModel: ViewModel
    
    var movie: Movie
    @State private var scrollOffset: CGFloat = 0

    var body: some View {
        GeometryReader { geometry in
            MovieDetailsBackground(movie: movie) {
                ScrollView() {
                    VStack(alignment: .leading, spacing: AppSpacing.vertical) {
                        Spacer()
                            .frame(height: geometry.size.height * 0.55)
                        
                        HStack(alignment: .center, spacing: AppSpacing.itemSpacing) {
                            Text(movie.title)
                                .font(.system(size: 28, weight: .bold, design: .default)) 
                                    .tracking(0.5) 
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .padding(.horizontal, AppSpacing.horizontal)
                            
                            Spacer()

                            RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                                .padding(.horizontal, AppSpacing.horizontal)
                        }

                        VStack(alignment: .leading, spacing: AppSpacing.vertical) {
                            if let genres = viewModel.movieDetails?.genres {
                                let genreNames = genres.map { $0.name }
                                GenresView(movieGenres: genreNames)
                                    .padding(.bottom, AppSpacing.vertical)
                                    .padding(.horizontal, AppSpacing.horizontal)
                            }

                            MovieOverviewView(overview: movie.overview)
                                .padding(.horizontal, AppSpacing.horizontal)

                           if !viewModel.castDetails.isEmpty {
                                Text("Cast")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .shadow(color: .shadow, radius: 1)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .padding(.horizontal, AppSpacing.horizontal)
                                
                                HorizontalScroll(items: viewModel.castDetails) { castMember in
                                    CastDetailsView(castItem: castMember)
                                }
                            }
                            
//                            if !viewModel.movieImages.isEmpty {
//                                MovieImagesView(images:viewModel.movieImages)
//                            }
                        } 
                        .padding(.bottom, geometry.safeAreaInsets.bottom + AppSpacing.vertical)
                    }
                    .background(
                        GeometryReader { proxy -> Color in
                            let offset = proxy.frame(in: .global).minY
                            DispatchQueue.main.async {
                                self.scrollOffset = offset
                            }
                            return Color.clear
                        }
                    )
                    .padding(.bottom, geometry.safeAreaInsets.bottom + AppSpacing.vertical)
                }
                .padding(.top, -geometry.safeAreaInsets.top)
            }
        }
        .background(Color(red: 0.15, green: 0.16, blue: 0.12))
        .toolbarBackground(Color.clear, for: .navigationBar) 
               .toolbarBackground(.hidden, for: .navigationBar)
        .onAppear {
            Task {
                await viewModel.fetchMovieDetails(movieId: movie.id)
                await viewModel.fetchCastDetails(movieId: movie.id)
                await viewModel.fetchMovieImages(movieId: movie.id)
            }
        }
    }
}

#Preview {
    MovieDetailsView(movie: .example)
        .environmentObject(ViewModel(movieService: MovieService()))
        .environmentObject(Persistence())
}
