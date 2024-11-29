//
//  MovieDetails.swift
//  MovieSearch
//
//  Created by Anna Filin on 25/11/2024.
//

import Foundation

struct MovieDetail: Codable {
    let adult: Bool
    let backdrop_path: String?
    let belongs_to_collection: MovieCollection?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdb_id: String?
    let origin_country: [String]
    let original_language: String
    let original_title: String
    let overview: String?
    let popularity: Double
    let poster_path: String?
    let production_companies: [ProductionCompany]
    let production_countries: [ProductionCountry]
    let release_date: String?
    let revenue: Int
    let runtime: Int?
    let spoken_languages: [SpokenLanguage]
    let status: String
    let tagline: String?
    let title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}


struct MovieCollection: Codable { 
    let id: Int
    let name: String
    let poster_path: String?
    let backdrop_path: String?
}


struct Genre: Codable {
    let id: Int
    let name: String
}

struct ProductionCompany: Codable {
    let id: Int
    let logo_path: String?
    let name: String
    let origin_country: String
}

struct ProductionCountry: Codable {
    let iso_3166_1: String
    let name: String
}

struct SpokenLanguage: Codable {
    let english_name: String
    let iso_639_1: String
    let name: String
}

//
//{
//  "adult": false,
//  "backdrop_path": null,
//  "belongs_to_collection": null,
//  "budget": 0,
//  "genres": [
//    {
//      "id": 10752,
//      "name": "War"
//    },
//    {
//      "id": 99,
//      "name": "Documentary"
//    }
//  ],
//  "homepage": "https://www.nfb.ca/film/sad-song-of-yellow-skin",
//  "id": 402378,
//  "imdb_id": "tt0198992",
//  "origin_country": [
//    "US",
//    "CA"
//  ],
//  "original_language": "en",
//  "original_title": "Sad Song of Yellow Skin",
//  "overview": "A film about the people of Saigon told through the experiences of three young American journalists who, in 1970, explored the consequences of war and of the American presence in Vietnam. It is not a film about the Vietnam War, but about the people who lived on the fringe of battle. The views of the city are arresting, but away from the shrines and the open-air markets lies another city, swollen with refugees and war orphans, where every inch of habitable space is coveted. (NFB)",
//  "popularity": 0.871,
//  "poster_path": null,
//  "production_companies": [
//    {
//      "id": 10473,
//      "logo_path": "/lMUDQZVtg8On4PAW5XFQPaQy6UK.png",
//      "name": "ONF | NFB",
//      "origin_country": "CA"
//    }
//  ],
//  "production_countries": [
//    {
//      "iso_3166_1": "CA",
//      "name": "Canada"
//    }
//  ],
//  "release_date": "1970-01-01",
//  "revenue": 0,
//  "runtime": 59,
//  "spoken_languages": [
//    {
//      "english_name": "Vietnamese",
//      "iso_639_1": "vi",
//      "name": "Tiếng Việt"
//    },
//    {
//      "english_name": "English",
//      "iso_639_1": "en",
//      "name": "English"
//    }
//  ],
//  "status": "Released",
//  "tagline": "",
//  "title": "Sad Song of Yellow Skin",
//  "video": false,
//  "vote_average": 7,
//  "vote_count": 1
//}
