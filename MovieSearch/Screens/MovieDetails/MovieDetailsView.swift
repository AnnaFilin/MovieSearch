//
//  MovieDetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var favorites: Persistence

    var movie: Movie
    
    @State var isLoading: Bool = false
    @State var errorMessage: String?
    @State var movieDetails: MovieDetail?
  
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                if let posterPath = movie.posterPath {
                ImageView(url: posterPath, width: nil, height: nil, opacity: 0.3, fillContentMode: true)
                        .ignoresSafeArea()
                        
                }
                
                ScrollView {
                    VStack(alignment: .leading, spacing: 8) {
                        Text( movie.title)
                            .font(.title.bold())
                            .shadow(color: .orange, radius: 1)
                            .multilineTextAlignment(.leading)
                            .lineLimit(nil)
                            .padding(.bottom, 5)
                       
                        if let movieTagline = movieDetails?.tagline {
                            Text(movieTagline)
                                .font(.title3)
                                .shadow(color: .orange, radius: 1)
                                .padding(.bottom, 2)
                        }
                        
                        HStack(alignment: .top, spacing: 16) {
                            if let posterPath = movie.posterPath {
                            ImageView(url: posterPath,  width: 150, height: 230, opacity: 0.9, fillContentMode: false)
                                    .cornerRadius(5)
                                    .shadow(color: .orange, radius: 1)
                            }
                            
                            if let movieDetails = movieDetails {
                                DetailsView(movieDetails: movieDetails, movie: movie)
                            }
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        if let genres = movieDetails?.genres {
                            let genreNames = genres.map { $0.name }
                            GenresView(movieGenres: genreNames)
                        }
                        
                        Text(movie.overview)
                        
                        if let productionCountries = movieDetails?.productionCountries {
                            HStack(alignment: .top) {
                                Image(systemName: "globe")
                                    .foregroundColor(.orange)
                                VStack(alignment: .leading) {
                                    Text("Production countries:")
                                        .font(.headline)
                                    let productionCountriesNames = productionCountries.map {$0.name}
                                    let movieCountries = ListFormatter.localizedString(byJoining: productionCountriesNames)
                                    
                                    Text(movieCountries)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.bottom)
                        }
                        
                        if let productionCompanies = movieDetails?.productionCompanies {
                            HStack(alignment: .top) {
                                Image(systemName: "building.2")
                                           .foregroundColor(.orange)
                                VStack(alignment: .leading) {
                                    Text("Production companies:")
                                        .font(.headline)
                                    let productionCompaniesNames = productionCompanies.map {$0.name}
                                    let movieCompanies = ListFormatter.localizedString(byJoining: productionCompaniesNames)
                                    
                                    Text(movieCompanies)
                                        .font(.subheadline)
                                        .foregroundColor(.white)
                                }
                            }
                            .padding(.bottom)
                        }
                        
                        if let spokenLanguages = movieDetails?.spokenLanguages {
                            HStack(alignment: .top) {
                                Image(systemName: "text.bubble")
                                    .foregroundColor(.orange)
                                VStack(alignment: .leading) {
                                    Text("Spoken languages:")
                                        .font(.headline)
                                    let spokenLanguagesNames = spokenLanguages.map {$0.name}
                                    let movieLanguages = ListFormatter.localizedString(byJoining: spokenLanguagesNames)
                                    
                                    Text(movieLanguages)
                                        .font(.subheadline)
                                }
                            }
                            .padding(.bottom)
                        }
                    }
                    .padding(.horizontal)
                    .padding(.bottom)
                    .padding(.bottom, geometry.safeAreaInsets.bottom)
                }
                .safeAreaInset(edge: .top, spacing: 0) { Spacer().frame(height: 16) }
   
            }
        }
        .background(Color(red: 0.15, green: 0.16, blue: 0.12))
        .ignoresSafeArea(edges: .bottom)
        .onAppear {
            Task {
                await fetchMovieDetails()
            }
        }
    }
    
    func fetchMovieDetails() async {
        isLoading = true
        errorMessage = nil

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

    isLoading = false
        
    }
}

#Preview {
    MovieDetailsView(movie: .example, movieDetails: .example)
        .environmentObject(Persistence())
}
