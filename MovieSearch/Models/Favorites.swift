//
//  Favorites.swift
//  MovieSearch
//
//  Created by Anna Filin on 23/11/2024.
//
import SwiftUI
import Combine


class Favorites: ObservableObject {
    // the actual movies the user has favorited
    @Published private(set) var movies: Set<String>

    private let key = "FavoriteMovies"

    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "FavoriteMovies") {
            if let decodedItems = try? JSONDecoder().decode(Set<String>.self, from: savedItems) {
                movies = decodedItems
                return
            }
        }

        movies = []
    }

    func contains(_ movie: Movie) -> Bool {
        movies.contains(String(movie.id))
    }

    // adds the resort to our set and saves the change
    func add(_ movie: Movie) {
        movies.insert(String(movie.id))
        save()
    }

    func remove(_ movie: Movie) {
        movies.remove(String(movie.id))
        save()
    }

    func save() {
        if let encoded = try? JSONEncoder().encode(movies) {
            UserDefaults.standard.set(encoded, forKey: "FavoriteMovies")
        }
    }
}
