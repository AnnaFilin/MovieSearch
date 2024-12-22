//
//  ContentViewModel.swift
//  MovieSearch
//
//  Created by Anna Filin on 20/11/2024.
//
//

import Combine
import Foundation

struct MovieResponse: Codable {
    let results: [Movie]
    let page: Int?
    let totalPages: Int?
    let totalResults: Int?
}


struct DataItem {
    let type: DataType
    let data: Any
    let title: String
}

enum DataType {
    case movieCard
    case tag
}



@MainActor
class ViewModel: ObservableObject {
    @Published var dataItems: [DataItem] = []
    
    @Published var trendingMovies: [Movie] = []
    @Published var popularMovies: [Movie] = []
    @Published var searchMovies: [Movie] = []
    @Published var searchText: String = ""
    @Published var searchGenre: String = ""
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    @Published var movieDetails: MovieDetail? = nil
    @Published var castDetails: [CastMember] = []
    
    private let movieService: MovieServiceProtocol
    private let savePath: URL
    private var cancellables = Set<AnyCancellable>()
    
    init(movieService: MovieServiceProtocol) {
        self.movieService = movieService
        self.savePath = URL.documentsDirectory.appending(path: "savedMovies.json")
        setupSearchDebounce()
        Task { await loadSavedMovies() }
    }
    
    private func setupSearchDebounce() {
        $searchText
            .debounce(for: .seconds(0.5), scheduler: DispatchQueue.main)
            .removeDuplicates()
            .sink { [weak self] query in
                guard let self = self else { return }
                Task {
                    await self.performSearch(query: query)
                }
            }
            .store(in: &cancellables)
    }

    
    func prepareData() async {
        isLoading = true
        errorMessage = nil
        
        do {
            let topRatedMovies = try await movieService.fetchTopRatedMovies()
            let popularMovies = try await movieService.fetchPopularMovies()
            let genres = Genre.allGenres
            
            dataItems = [
                DataItem(type: .movieCard, data: topRatedMovies, title: "Top Rated"),
                DataItem(type: .tag, data: genres, title: "Genres"),
                DataItem(type: .movieCard, data: popularMovies, title: "Popular")
            ]
        } catch {
            errorMessage = "Failed loading movies: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    
    func fetchMoviesByGenre(genre: Genre) async {
        isLoading = true
        errorMessage = nil
        
        do {
            let movies = try await movieService.fetchMoviesByGenre(genreID: genre.id)
            self.searchMovies = movies
            self.searchGenre = genre.name
        } catch {
            self.errorMessage = "Failed to fetch movies by genre: \(error.localizedDescription)"
        }
        
        isLoading = false
    }
    
    private func performSearch(query: String) async {
        let trimmedQuery = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmedQuery.isEmpty else {
            self.searchMovies = []
            return
        }
        await fetchMovies { try await self.movieService.searchMovies(query: trimmedQuery) } update: { self.searchMovies = $0 }
    }
    
    
    private func fetchMovies(_ fetcher: () async throws -> [Movie], update: @escaping ([Movie]) -> Void) async {
        isLoading = true
        errorMessage = nil
        do {
            let movies = try await fetcher()
            update(movies)
            await saveMovies(movies: movies)
        } catch {
            errorMessage = "Failed to load movies: \(error.localizedDescription)"
            print(errorMessage ?? "Unknown error")
        }
        isLoading = false
    }
    
    private func saveMovies(movies: [Movie]) async {
        do {
            let data = try JSONEncoder().encode(movies)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Movies saved successfully to \(savePath)")
        } catch {
            print("Failed to save movies: \(error.localizedDescription)")
        }
    }
    
    private func loadSavedMovies() async {
        do {
            let data = try Data(contentsOf: savePath)
            let savedMovies = try JSONDecoder().decode([Movie].self, from: data)
            self.trendingMovies = savedMovies
            print("Movies loaded successfully from \(savePath)")
        } catch {
            print("No saved movies found or failed to load: \(error.localizedDescription)")
        }
    }
    
    func resetSavedMovies() async {
        do {
            try FileManager.default.removeItem(at: savePath)
            self.trendingMovies = []
            print("Saved movies reset successfully.")
        } catch {
            print("Error deleting saved movies file: \(error.localizedDescription)")
        }
    }
    
    func fetchMovieDetails(movieId: Int) async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let details = try await movieService.fetchMovieDetails(movieId: movieId)
            self.movieDetails = details
            
        } catch {
            self.errorMessage = "Failed to fetch movie details: \(error.localizedDescription)"
        }
        
        self.isLoading = false
       
    }
    
    func fetchCastDetails(movieId: Int) async {
        self.isLoading = true
        self.errorMessage = nil
        
        do {
            let details = try await movieService.fetchCastDetails(movieId: movieId)
            self.castDetails = details
            
        } catch {
            self.errorMessage = "Failed to fetch cast details: \(error.localizedDescription)"
        }
        
        self.isLoading = false
       
    }
    
}
