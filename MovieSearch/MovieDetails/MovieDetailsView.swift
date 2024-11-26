//
//  MovieDetailsView.swift
//  MovieSearch
//
//  Created by Anna Filin on 19/11/2024.
//

import SwiftUI

struct MovieDetailsView: View {
    @EnvironmentObject var favorites: Favorites

    var movie: Movie
    
    @State var isLoading: Bool = false
    @State var errorMessage: String?
    @State var movieDetails: MovieDetail?
  
    
    var body: some View {
        ZStack {
            
            if let posterPath = movie.poster_path {
                ImageView(url: posterPath, width: nil, height: nil, opacity: 0.3, fillContentMode: true)
                    .ignoresSafeArea()
            }
            
            ScrollView {
                
                VStack(alignment: .leading, spacing: 8) {
                    Text( movie.title)
                        .font(.title2.bold())
                        .multilineTextAlignment(.leading)
                        .lineLimit(nil)
                        .padding(.bottom, 5)
                   
                    Text(movieDetails?.tagline ?? movie.title)
                        .font(.title3)
                        .padding(.bottom, 2)
                    
                    HStack(alignment: .top, spacing: 16) {
                        if let posterPath = movie.poster_path {
                            ImageView(url: posterPath,  width: 150, height: 230, opacity: 0.9, fillContentMode: false)
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

                    if let productionCountries = movieDetails?.production_countries {
                        HStack(alignment: .top) {
                            Text("Production countries:")
                            let productionCountriesNames = productionCountries.map {$0.name}
                            let movieCountries = ListFormatter.localizedString(byJoining: productionCountriesNames)
                            
                            Text(movieCountries)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom)
                    }
                            
                    if let productionCompanies = movieDetails?.production_companies {
                        HStack(alignment: .top) {
                        Text("Production companies:")
                            let productionCompaniesNames = productionCompanies.map {$0.name}
                            let movieCompanies = ListFormatter.localizedString(byJoining: productionCompaniesNames)
                            
                            Text(movieCompanies)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom)
                    }
                        
                    if let spokenLanguages = movieDetails?.spoken_languages {
                        HStack(alignment: .top) {
                            Text("Spoken languages:")
                            let spokenLanguagesNames = spokenLanguages.map {$0.name}
                            let movieLanguages = ListFormatter.localizedString(byJoining: spokenLanguagesNames)
                            
                            Text(movieLanguages)
                                .font(.subheadline)
                                .foregroundColor(.white)
                        }
                        .padding(.bottom)
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
                .foregroundStyle(.white)
            }
            .safeAreaInset(edge: .top, spacing: 0) { Spacer().frame(height: 44) }      
        }
        .navigationTitle(movie.title)
        .navigationBarTitleDisplayMode(.inline)
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
    let wickedMovie = Movie(
        id: 402431,
           title: "Wicked",
           original_title: "Wicked",
           original_language: "en",
           overview: """
               Elphaba, an ostracized but defiant girl born with green skin, and Galinda, 
               a privileged aristocrat born popular, become extremely unlikely friends 
               in the magical Land of Oz. As the two girls struggle with their opposing 
               personalities, their friendship is tested as both begin to fulfil their destinies 
               as Glinda the Good and The Wicked Witch of the West.
               """,
           poster_path: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
           backdrop_path: "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
           genre_ids: [18, 14, 10749],
           release_date: "2024-11-20",
           popularity: 927.236,
           vote_average: 7.5,
           vote_count: 30,
           adult: false,
           video: false
    )
    
    let details = MovieDetail(
        adult: false,
        backdrop_path: "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
        belongs_to_collection: MovieCollection(
            id: 968080,
            name: "Wicked Collection",
            poster_path: "/b9xo966oVIrFtpevhLQ9XILcXTh.jpg",
            backdrop_path: "/xFcLusbzDM86mla4vjdEBHi7jLW.jpg"
        ),
        budget: 145000000,
        genres: [
            Genre(id: 18, name: "Drama"),
            Genre(id: 14, name: "Fantasy"),
            Genre(id: 10749, name: "Romance")
        ],
        homepage: "https://www.wickedmovie.com",
        id: 402431,
        imdb_id: "tt1262426",
        origin_country: ["US"],
        original_language: "en",
        original_title: "Wicked",
        overview: "Elphaba, a young woman misunderstood because of her green skin, and Glinda, a popular aristocrat gilded by privilege, become unlikely friends in the fantastical Land of Oz. As the two women struggle with their opposing personalities, their friendship is tested as both begin to fulfill their destinies as Glinda the Good and the Wicked Witch of the West.",
        popularity: 1334.482,
        poster_path: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
        production_companies: [
            ProductionCompany(id: 33, logo_path: "/3wwjVpkZtnog6lSKzWDjvw2Yi00.png", name: "Universal Pictures", origin_country: "US"),
            ProductionCompany(id: 2527, logo_path: "/osO7TGmlRMistSQ5JZusPhbKUHk.png", name: "Marc Platt Productions", origin_country: "US")
        ],
        production_countries: [
            ProductionCountry(iso_3166_1: "US", name: "United States of America")
        ],
        release_date: "2024-11-20",
        revenue: 0,
        runtime: 161,
        spoken_languages: [
            SpokenLanguage(english_name: "English", iso_639_1: "en", name: "English")
        ],
        status: "Released",
        tagline: "Everyone deserves the chance to fly.",
        title: "Wicked",
        video: false,
        vote_average: 7.713,
        vote_count: 82
    )
   
    MovieDetailsView(movie: wickedMovie, movieDetails: details)
        .environmentObject(Favorites())
}
