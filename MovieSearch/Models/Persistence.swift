//
//  Favorites.swift
//  MovieSearch
//
//  Created by Anna Filin on 23/11/2024.
//
import SwiftUI
import Combine


class Persistence: ObservableObject {
    @Published private(set) var favoritedMovies: Set<String>

    private let key = "FavoriteMovies"

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: key) {
            if let decodedItems = try? JSONDecoder().decode(Set<String>.self, from: savedItems) {
                favoritedMovies = decodedItems
                return
            }
        }

        favoritedMovies = []
    }

    func contains(_ movie: Movie) -> Bool {
        favoritedMovies.contains(String(movie.id))
    }

    func add(_ movie: Movie) {
        favoritedMovies.insert(String(movie.id))
        save()
    }

    func remove(_ movie: Movie) {
        favoritedMovies.remove(String(movie.id))
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(favoritedMovies) {
            UserDefaults.standard.set(encoded, forKey: key)
        }
    }
}
