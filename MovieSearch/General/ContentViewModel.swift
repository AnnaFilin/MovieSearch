//
//  ContentViewModel.swift
//  MovieSearch
//
//  Created by Anna Filin on 20/11/2024.
//

import Foundation
import SwiftUI

import Combine


struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
}

@MainActor
class ViewModel: ObservableObject {
    @Published var movies: [Movie] = []
    @Published var searchMovies: [Movie] = []
    @Published var topRatedMovies: [Movie] = []

    @Published var trendingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var searchText: String = ""
    @Published var searchGenre: String = ""

    
    @Published var isLoading: Bool = false
    @Published var isSearching: Bool = false
    @Published var errorMessage: String?
    
    private var cancellables = Set<AnyCancellable>()
    
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main) // 0.5-second debounce
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                Task {
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
    }

    let savePath = URL.documentsDirectory.appending(path: "MockMovies")
    
    init() {
        setupSearchDebounce()
    }
    
    func fetchMovies() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Config.apiKey)") else {
            errorMessage = "Invalid URL."
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)

            self.movies = movieResponse.results
            self.trendingMovies = movies
            await saveMovies()
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
            print(errorMessage ?? "Unknown error")
        }

        isLoading = false
    }
    
    func fetchPopularMovies() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=\(Config.apiKey)") else {
            errorMessage = "Invalid URL."
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)

            self.popularMovies = movieResponse.results
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
            print(errorMessage ?? "Unknown error")
        }

        isLoading = false
    }

    func fetchTopRatedMovies() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://api.themoviedb.org/3/movie/top_rated?api_key=\(Config.apiKey)") else {
            errorMessage = "Invalid URL."
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)

            self.topRatedMovies = movieResponse.results
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
            print(errorMessage ?? "Unknown error")
        }

        isLoading = false
    }


    func loadSavedMovies() async {
        if FileManager.default.fileExists(atPath: savePath.path) {
            do {
                let data = try Data(contentsOf: savePath)
                self.movies = try JSONDecoder().decode([Movie].self, from: data)
                self.trendingMovies = movies
                print("Movies loaded from save path.")
            } catch {
                print("Failed to decode saved movies: \(error.localizedDescription)")
            }
            } else if let bundleURL = Bundle.main.url(forResource: "MockMovies", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: bundleURL)
                    self.movies = try JSONDecoder().decode([Movie].self, from: data)
                    self.trendingMovies = movies
                    print("Movies loaded from bundle.")
                } catch {
                    print("Error loading bundled movies: \(error.localizedDescription)")
                }
            } else {
                print("No saved movies found.")
                self.movies = []
                self.trendingMovies = movies
            }
    }

    func saveMovies() async {
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Movies saved successfully.")
        } catch {
            print("Failed to save movies: \(error.localizedDescription)")
        }
    }
    
    func resetSavedMovies() async {
        do {
            try FileManager.default.removeItem(at: savePath)
            movies = []
        } catch {
            print("Error deleting saved file: \(error.localizedDescription)")
        }
    }
    
//    func searchMovies(query: String) async {
//
//        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
//               guard !trimmedQuery.isEmpty else {
//                   self.searchMovies = []
//                   self.errorMessage = nil
//                   return
//               }
//        
//                isLoading = true
//                isSearching = true
//                errorMessage = nil
//
//        guard var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie") else {
//               errorMessage = "Invalid URL."
//               isLoading = false
//               return
//           }
//
//       components.queryItems = [
//           URLQueryItem(name: "query", value: query),
//           URLQueryItem(name: "include_adult", value: "false"),
//           URLQueryItem(name: "language", value: "en-US"),
//           URLQueryItem(name: "page", value: "1"),
//           URLQueryItem(name: "api_key", value: Config.apiKey)
//       ]
//
//       guard let url = components.url else {
//           errorMessage = "Failed to construct URL."
//           return
//       }
//
//       do {
//           let (data, _) = try await URLSession.shared.data(from: url)
//
//           let decodedMovies = try JSONDecoder().decode(MovieResponse.self, from: data)
//           self.searchMovies = decodedMovies.results
//       } catch {
//               errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
//       }
//
//       isLoading = false
//    }
//
    
    private func performSearch(query: String) async {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            self.searchMovies = []
            self.errorMessage = nil
            return
        }

        isLoading = true
        isSearching = true
        errorMessage = nil

        do {
            let results = try await fetchMoviesFromAPI(query: trimmedQuery)
            self.searchMovies = results
        } catch {
            self.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
        }

        isLoading = false
        isSearching = false
    }

    
    
    private func fetchMoviesFromAPI(query: String) async throws -> [Movie] {
          guard var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie") else {
              throw URLError(.badURL)
          }

          components.queryItems = [
              URLQueryItem(name: "query", value: query),
              URLQueryItem(name: "include_adult", value: "false"),
              URLQueryItem(name: "language", value: "en-US"),
              URLQueryItem(name: "page", value: "1"),
              URLQueryItem(name: "api_key", value: Config.apiKey)
          ]

          guard let url = components.url else {
              throw URLError(.badURL)
          }

          let (data, response) = try await URLSession.shared.data(from: url)

          if let httpResponse = response as? HTTPURLResponse, !(200...299).contains(httpResponse.statusCode) {
              throw URLError(.badServerResponse)
          }

          let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
          return decodedResponse.results
      }
    
    
    func fetchMoviesByGenre(genre: Genre) async {
        
        self.isLoading = true
        self.errorMessage = nil
        self.searchGenre = genre.name
        
        guard let url = URL(string: "https://api.themoviedb.org/3/discover/movie?api_key=\(Config.apiKey)&with_genres=\(genre.id)") else {
            self.errorMessage = "Invalid URL."
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
            
            self.searchMovies = movieResponse.results
            print(movieResponse.results[0])
        } catch {
            self.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
            print(self.errorMessage ?? "Unknown error")
        }
        
        self.isLoading = false
        
    }
}

