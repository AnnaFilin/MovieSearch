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
  
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let posterPath = movie.posterPath {
                    ImageView(url: posterPath, width: nil, height: nil, opacity: 1.0, fillContentMode: true)
                        .ignoresSafeArea()          
                }
                    LinearGradient(
                        gradient: Gradient(colors: [.background.opacity(0.001), .background.opacity(0.01), .background.opacity(0.6), .background.opacity(0.9)]),
                        startPoint: .top,
                        endPoint: .center
                    ) 

                VStack(alignment: .leading, spacing: AppSpacing.vertical) {
                    Spacer()
                    
                    HStack(alignment: .center, spacing: AppSpacing.itemSpacing) {
                        Text( movie.title)
                            .font(.title.bold())
                            .shadow(color: .shadow, radius: 1)
                            .opacity(0.7)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.horizontal, AppSpacing.itemSpacing)
                        
                        Spacer()

                        RatingView(voteAverage: movie.voteAverage, voteCount: movie.voteCount)
                    }
                    
                    ScrollView {
                       
                        VStack(alignment: .leading, spacing: AppSpacing.vertical) {

                            if let genres = movieDetails?.genres {
                                let genreNames = genres.map { $0.name }
                                GenresView(movieGenres: genreNames)
                                    .padding(.bottom, AppSpacing.itemSpacing)
                            }
                            
                            MovieOverviewView(overview: movie.overview)
                            
                            if let castDetails = castDetails {
                                Text("Cast")
                                    .font(.title2)
                                    .fontWeight(.bold)
                                    .shadow(color: .shadow, radius: 1)
                                    .opacity(0.65)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(nil)
                                   
                                HorizontalScroll(items: castDetails) { castMember in
                                  CastDetailsView(castItem: castMember)
                              }

                            }
                        }
                        .padding(.bottom, geometry.safeAreaInsets.bottom + AppSpacing.vertical)
                        .foregroundStyle(.theme)
                    }
                    .frame(height: geometry.size.height * 0.6)
                    .padding(.horizontal, AppSpacing.itemSpacing)
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
                .foregroundStyle(.theme)
                .padding(.horizontal, AppSpacing.horizontal)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .background(Color(red: 0.15, green: 0.16, blue: 0.12))
        .onAppear {
            self.isLoading = true
            Task {
                await fetchMovieDetails()
                await fetchCastDetails()
                self.isLoading=false
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
        
//        print("Request URL: \(url)")

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
