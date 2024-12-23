//
//  MovieService.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/12/2024.
//

import Foundation

struct MovieService: MovieServiceProtocol {
    
    private let apiKey = Config.apiKey
    private let baseURL = "https://api.themoviedb.org/3"
    
    func fetchTrendingMovies() async throws -> [Movie] {
        let url = URL(string: "\(baseURL)/trending/movie/day?api_key=\(apiKey)")!
        return try await fetchMovies(from: url)
    }
    
    func fetchPopularMovies() async throws -> [Movie] {
        let url = URL(string: "\(baseURL)/movie/popular?api_key=\(apiKey)")!
        return try await fetchMovies(from: url)
    }
    
    func fetchTopRatedMovies() async throws -> [Movie] {
        let url = URL(string: "\(baseURL)/movie/top_rated?api_key=\(apiKey)")!
        return try await fetchMovies(from: url)
    }
    
    func searchMovies(query: String) async throws -> [Movie] {
        var components = URLComponents(string: "\(baseURL)/search/movie")!
        components.queryItems = [
            URLQueryItem(name: "query", value: query),
            URLQueryItem(name: "api_key", value: apiKey)
        ]
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        return try await fetchMovies(from: url)
    }
    
    func fetchMoviesByGenre(genreID: Int) async throws -> [Movie] {
        let url = URL(string: "\(baseURL)/discover/movie?api_key=\(apiKey)&with_genres=\(genreID)")!
        return try await fetchMovies(from: url)
    }
    
    
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetail {
        var components = URLComponents(string: "\(baseURL)/movie/\(movieId)?api_key=\(apiKey)")!
        
        components.queryItems = [
            URLQueryItem(name: "language", value: "en-US"),
            URLQueryItem(name: "api_key", value: Config.apiKey)
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let request = URLRequest(url: url)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                throw URLError(.badServerResponse)
            }
            
            let decodedMovieDetails = try JSONDecoder().decode(MovieDetail.self, from: data)
            
            return decodedMovieDetails
        } catch {
            print("Failed to fetch movie details: \(error.localizedDescription)")
            throw error
        }
    }
    
    func fetchCastDetails(movieId: Int) async throws -> [CastMember] {
            var components = URLComponents(string: "\(baseURL)/movie/\(movieId)/credits")!
    
            components.queryItems = [
                URLQueryItem(name: "language", value: "en-US"),
                URLQueryItem(name: "api_key", value: Config.apiKey)
            ]
    
            guard let url = components.url else {
                throw URLError(.badURL)
            }
    
            let request = URLRequest(url: url)
    
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
    
                let decodedCastResponse = try JSONDecoder().decode(CastResponse.self, from: data)
    
                return decodedCastResponse.cast
            } catch {
              
                print("Failed to fetch cast details: \(error.localizedDescription)")
                throw error
            }
        }
    
    func fetchMovieImages(movieId: Int) async throws -> [MovieImage] {
            var components = URLComponents(string: "\(baseURL)/movie/\(movieId)/images")!
    
            components.queryItems = [
                URLQueryItem(name: "include_image_language", value: "en"),
                URLQueryItem(name: "api_key", value: Config.apiKey)
            ]
    
            guard let url = components.url else {
                throw URLError(.badURL)
            }
    
            let request = URLRequest(url: url)
    
            do {
                let (data, _) = try await URLSession.shared.data(for: request)
                let decodedMovieImages = try JSONDecoder().decode(MovieImagesResponse.self, from: data)
    
                return decodedMovieImages.posters
            } catch {
              
                print("Failed to fetch cast details: \(error.localizedDescription)")
                throw error
            }
        }
    
    
    private func fetchMovies(from url: URL) async throws -> [Movie] {
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }
        let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
        return movieResponse.results
    }
    
    
}
