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

struct MovieDetailsView: View {
    @EnvironmentObject var favorites: Persistence

    var movie: Movie
    @State var castDetails: [CastMember]?
    @State var isLoading: Bool = false
    @State var errorMessage: String?
    @State var movieDetails: MovieDetail?

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
//                                .font(.title.bold())
//                                .shadow(color: .shadow, radius: 1)
//                                .font(.title)        // Заголовок
//                                       .fontWeight(.bold)
                                .font(.system(size: 28, weight: .bold, design: .default)) // SF Pro Display
                                    .tracking(0.5) 
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                                .padding(.horizontal, AppSpacing.horizontal)
                            
                            Spacer()

                            RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                                .padding(.horizontal, AppSpacing.horizontal)
                        }

                        VStack(alignment: .leading, spacing: AppSpacing.vertical) {
                            if let genres = movieDetails?.genres {
                                let genreNames = genres.map { $0.name }
                                GenresView(movieGenres: genreNames)
                                    .padding(.bottom, AppSpacing.vertical)
                                    .padding(.horizontal, AppSpacing.horizontal)
                            }

                            MovieOverviewView(overview: movie.overview)
                                .padding(.horizontal, AppSpacing.horizontal)

                            if let castDetails = castDetails {
                                Text("Cast")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .shadow(color: .shadow, radius: 1)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                    .padding(.horizontal, AppSpacing.horizontal)
                                
                                HorizontalScroll(items: castDetails) { castMember in
                                    CastDetailsView(castItem: castMember)
                                }
                            }
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
        .onAppear {
            self.isLoading = true
            Task {
                await fetchMovieDetails()
                await fetchCastDetails()
                self.isLoading = false
            }
        }
    }
    
    
    func fetchMovieDetails() async {
           print("API Key from Config: \(Config.apiKey)")
           guard var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movie.id)") else {
                  errorMessage = "Invalid URL."
                  return
              }
   
           components.queryItems = [
             URLQueryItem(name: "language", value: "en-US"),
             URLQueryItem(name: "api_key", value: Config.apiKey)
           ]
   
          guard let url = components.url else {
              errorMessage = "Failed to construct URL."
              return
          }
   
           let request = URLRequest(url: url)
   
           do {
               let (data, _) = try await URLSession.shared.data(for: request)
   
               let decodedMovieDetails = try JSONDecoder().decode(MovieDetail.self, from: data)
               self.movieDetails = decodedMovieDetails
   
           } catch {
               errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
           }
       }
   
    func fetchCastDetails() async {
        guard var components = URLComponents(string: "https://api.themoviedb.org/3/movie/\(movie.id)/credits") else {
                errorMessage = "Invalid URL."
                return
            }

        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "api_key", value: Config.apiKey)
        ]

        guard let url = components.url else {
            errorMessage = "Failed to construct URL."
            return
        }

        let request = URLRequest(url: url)

        do {
            let (data, _) = try await URLSession.shared.data(for: request)

            let decodedCastResponse = try JSONDecoder().decode(CastResponse.self, from: data)

            self.castDetails = decodedCastResponse.cast
        } catch {
            errorMessage = "Failed to fetch cast details: \(error.localizedDescription)"
            print(errorMessage ?? "Unknown error")
        }
    }
}

#Preview {
    MovieDetailsView(movie: .example, castDetails: [.example], movieDetails: .example)
        .environmentObject(Persistence())
}
