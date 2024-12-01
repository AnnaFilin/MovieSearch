//
//  Movie.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import Foundation

struct Movie: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let original_title: String?
    let original_language: String?
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let genre_ids: [Int]?
    let release_date: String?
    let popularity: Float
    let vote_average: Float?
    let vote_count: Int?
    let adult: Bool
    let video: Bool
    
    
    static let allMovies: [Movie] = Bundle.main.decode("MockMovies.json")
    static let example = allMovies[0]
}
