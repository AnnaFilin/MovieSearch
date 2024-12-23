//
//  MovieImage.swift
//  MovieSearch
//
//  Created by Anna Filin on 23/12/2024.
//

import Foundation

struct MovieImage: Codable {
    let aspectRatio: Double
        let height: Int
        let iso639_1: String?
        let filePath: String
        let voteAverage: Double
        let voteCount, width: Int

        enum CodingKeys: String, CodingKey {
            case aspectRatio = "aspect_ratio"
            case height
            case iso639_1 = "iso_639_1"
            case filePath = "file_path"
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
            case width
        }
    
    init(aspectRatio: Double, height: Int, iso639_1: String?, filePath: String, voteAverage: Double, voteCount: Int, width: Int) {
        self.aspectRatio = aspectRatio
        self.height = height
        self.iso639_1 = iso639_1
        self.filePath = filePath
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.width = width
    }
    
    static let allImages: [MovieImage] = Bundle.main.decode("MovieImagesMock.json")
    static let example = allImages[0]
}
