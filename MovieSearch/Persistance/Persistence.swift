//
//  Favorites.swift
//  MovieSearch
//
//  Created by Anna Filin on 23/11/2024.
//
import SwiftUI
import Combine


class Persistence: ObservableObject {
    @Published private(set) var favoritedMovies: Set<Movie>
    
    private let key = "FavoriteMovies"

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode(Set<Movie>.self, from: savedItems) {
                favoritedMovies = decodedItems
                return
            }
        }

        favoritedMovies = []
    }

    func contains(_ movie: Movie) -> Bool {
        favoritedMovies.contains(movie)
    }

    func add(_ movie: Movie) {
        favoritedMovies.insert(movie)
        save()
    }

    func remove(_ movie: Movie) {
        favoritedMovies.remove(movie)
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(favoritedMovies) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
