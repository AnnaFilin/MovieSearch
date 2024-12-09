//
//  ContentViewModel.swift
//  MovieSearch
//
//  Created by Anna Filin on 20/11/2024.
//

import Foundation

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

    @Published var searchText: String = "" {
        didSet {
            debounceSearch()
        }
    }
    @Published var isLoading: Bool = false
    @Published var isSearching: Bool = false
    @Published var errorMessage: String?
    
    private var searchTask: Task<Void, Never>? = nil
    
    private func debounceSearch() {
        searchTask?.cancel()

        searchTask = Task {
            do {
                guard !searchText.isEmpty else {
                    print("Search text is empty. Clearing results.")
                    self.searchMovies = []
                    return
                }

                try await Task.sleep(nanoseconds: 500_000_000)
                if Task.isCancelled { return }

                print("Performing search for: \(searchText)")
                await searchMovies(query: searchText)
            } catch {
                if !(error is CancellationError) {
                    print("Unexpected error during debounce: \(error)")
                }
            }
        }
    }

    let savePath = URL.documentsDirectory.appending(path: "MockMovies")
    
    init() { }
    
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
    
//    let url = URL(string: "")!
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
    
    func searchMovies(query: String) async {
        isLoading = true
        isSearching = true
        errorMessage = nil

        guard var components = URLComponents(string: "https://api.themoviedb.org/3/search/movie") else {
               errorMessage = "Invalid URL."
               isLoading = false
               return
           }

       components.queryItems = [
           URLQueryItem(name: "query", value: query),
           URLQueryItem(name: "include_adult", value: "false"),
           URLQueryItem(name: "language", value: "en-US"),
           URLQueryItem(name: "page", value: "1"),
           URLQueryItem(name: "api_key", value: Config.apiKey)
       ]

       guard let url = components.url else {
           errorMessage = "Failed to construct URL."
           return
       }

       do {
           let (data, _) = try await URLSession.shared.data(from: url)

           let decodedMovies = try JSONDecoder().decode(MovieResponse.self, from: data)
           self.searchMovies = decodedMovies.results
//           self.movies = searchMovies
       } catch {
               errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
       }

       isLoading = false
    }
    
}

