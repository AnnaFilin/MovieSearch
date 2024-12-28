//
//  Movie.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
       let title, originalTitle, originalLanguage, overview: String
       let posterPath, backdropPath: String?
       let genreIDS: [Int]
       let releaseDate: String?
       let popularity, voteAverage: Double
       let voteCount: Int?
       let adult, video: Bool

       enum CodingKeys: String, CodingKey {
           case id, title
           case originalTitle = "original_title"
           case originalLanguage = "original_language"
           case overview
           case posterPath = "poster_path"
           case backdropPath = "backdrop_path"
           case genreIDS = "genre_ids"
           case releaseDate = "release_date"
           case popularity
           case voteAverage = "vote_average"
           case voteCount = "vote_count"
           case adult, video
       }
    
    init(id: Int, title: String, originalTitle: String, originalLanguage: String, overview: String, posterPath: String, backdropPath: String, genreIDS: [Int], releaseDate: String, popularity: Double, voteAverage: Double, voteCount: Int, adult: Bool, video: Bool) {
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.genreIDS = genreIDS
        self.releaseDate = releaseDate
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.adult = adult
        self.video = video
    }
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
            lhs.id == rhs.id
        }

        func hash(into hasher: inout Hasher) {
            hasher.combine(id)
        }
    
    static let allMovies: [Movie] = Bundle.main.decode("MockMovies.json")
    static let example = allMovies[0]
}
