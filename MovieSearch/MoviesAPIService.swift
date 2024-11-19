//
//  MoviesAPIService.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}


class MoviesAPIService {
    private let apiKey = "e73ba60c89msh843aae1bedebf94p1f6d27jsn18419874edcd"
    private let baseURL = "https://advanced-movie-search.p.rapidapi.com" 

    func fetchMovies(completion: @escaping (Result<[Movie], Error>) -> Void) {
           guard let url = URL(string: "\(baseURL)/discover/movie?with_genres=80&page=1") else {
               completion(.failure(URLError(.badURL)))
               return
           }

           var request = URLRequest(url: url)
           request.httpMethod = "GET"
           request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
           request.setValue("advanced-movie-search.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")

           URLSession.shared.dataTask(with: request) { data, response, error in
               if let error = error {
                   completion(.failure(error))
                   return
               }

               guard let data = data else {
                   completion(.failure(URLError(.badServerResponse)))
                   return
               }

               do {
                   let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
                   completion(.success(decodedResponse.results))
               } catch {
                   completion(.failure(error))
               }
           }.resume()
       }
}
