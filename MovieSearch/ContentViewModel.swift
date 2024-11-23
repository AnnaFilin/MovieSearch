//
//  ContentViewModel.swift
//  MovieSearch
//
//  Created by Anna Filin on 20/11/2024.
//

import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
}

@MainActor
class ViewModel: ObservableObject {
   

    @Published var movies: [Movie] = []
    @Published var searchText: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    let savePath = URL.documentsDirectory.appending(path: "SavedMovies")
//    let savePath = URL.documentsDirectory.appendingPathComponent("SavedMovies.json")

    
    init() {
        Task {
           await loadSavedMovies()
        }
    }

    func loadSavedMovies() async {
        // Try loading saved data from UserDefaults
//         if let savedData = UserDefaults.standard.data(forKey: "SavedMovies") {
//             if let decodedMovies = try? JSONDecoder().decode([Movie].self, from: savedData) {
//                 movies = decodedMovies
//                 return
//             }
//         }
//         
//         // Fallback to loading bundled JSON
//         if let bundledMovies: MovieResponse = Bundle.main.decode("SavedMovies.json") {
//             movies = bundledMovies.results
//         } else {
//             movies = [] // Default to an empty array if all else fails
//         }
        // Check if saved file exists in the documents directory
               if FileManager.default.fileExists(atPath: savePath.path) {
                   do {
                       let data = try Data(contentsOf: savePath)
                       let decodedMovies = try JSONDecoder().decode([Movie].self, from: data)
                       movies = decodedMovies
                       return
                   } catch {
                       print("Failed to load saved movies: \(error.localizedDescription)")
                   }
               }

               // Fallback to bundled JSON
               if let bundledMovies: MovieResponse = Bundle.main.decode("SavedMovies.json") {
                   movies = bundledMovies.results
               } else {
                   movies = [] // Default to an empty array if all else fails
               }
    }

    func saveMovies() async {
//        do {
//            let data = try JSONEncoder().encode(movies)
//            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
//        } catch {
//            print("Unable to save data.")
//        }
        do {
                   let data = try JSONEncoder().encode(movies)
                   try data.write(to: savePath, options: [.atomic, .completeFileProtection])
               } catch {
                   print("Unable to save movies: \(error.localizedDescription)")
               }
    }

    func fetchMovies(query: String? = nil) async {
        isLoading = true
        errorMessage = nil
        
        let endpoint: String
        if let query = query, !query.isEmpty {
            endpoint = "\(baseURL)/search/movie?query=\(query)&page=1"
        } else {
            endpoint = "\(baseURL)/discover/movie?with_genres=80&page=1"
        }
        
        guard let url = URL(string: endpoint) else {
            errorMessage = "Invalid URL."
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue(apiKey, forHTTPHeaderField: "x-rapidapi-key")
        request.setValue("advanced-movie-search.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON: \(jsonString)")
                }
            
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            decoder.dateDecodingStrategy = .iso8601
            
            if let decodedMovies = try? decoder.decode([Movie].self, from: data) {
                
                if let query = query, !query.isEmpty {
                    movies = decodedMovies
                }
                else {
                    movies = decodedMovies
                    await saveMovies()
                }
                
            } else {
                print("Failed to decode JSON")
            }
        } catch {
            errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
        }
        isLoading = false
    }
  
    
//        URLSession.shared.dataTask(with: request) { [weak self] data, response, error in
//            DispatchQueue.main.async {
//                self?.isLoading = false
//                
//                if let error = error {
//                    self?.errorMessage = "Failed to fetch movies: \(error.localizedDescription)"
//                    return
//                }
//
//                guard let data = data else {
//                    self?.errorMessage = "No data received from server."
//                    return
//                }
//
//                do {
//                    let decodedResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
//                    self?.movies = decodedResponse.results
//                } catch {
//                    self?.errorMessage = "Failed to decode movies: \(error.localizedDescription)"
//                }
//            }
//        }
//        .resume()
   
}

