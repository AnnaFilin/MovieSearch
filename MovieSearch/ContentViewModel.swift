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
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let savePath = URL.documentsDirectory.appending(path: "SavedMovies")
    
    init() { }
    
    func fetchMovies() async {
        isLoading = true
        errorMessage = nil

        guard let url = URL(string: "https://api.themoviedb.org/3/trending/movie/day?api_key=\(Config.apiKey)") else {
            errorMessage = "Invalid URL."
            isLoading = false
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)

            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)

            self.movies = movieResponse.results

            await saveMovies()
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
                print("Movies loaded from save path.")
            } catch {
                print("Failed to decode saved movies: \(error.localizedDescription)")
            }
            } else if let bundleURL = Bundle.main.url(forResource: "SavedMovies", withExtension: "json") {
                do {
                    let data = try Data(contentsOf: bundleURL)
                    self.movies = try JSONDecoder().decode([Movie].self, from: data)
                    print("Movies loaded from bundle.")
                } catch {
                    print("Error loading bundled movies: \(error.localizedDescription)")
                }
            } else {
                print("No saved movies found.")
                self.movies = []
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
}

