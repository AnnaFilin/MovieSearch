//
//  FavoritesButtonView.swift
//  MovieSearch
//
//  Created by Anna Filin on 03/12/2024.
//

import SwiftUI


struct FavoritesButtonView: View {
    @EnvironmentObject var favorites: Persistence

    var movie: Movie
    
    var body: some View {
        Button(action: {
            if favorites.contains(movie) {
                favorites.remove(movie)
            } else {
                favorites.add(movie)
            }
        }) {
            Image(systemName: favorites.contains(movie) ? "heart.fill" : "heart")
                .font(.title2)
                .fontWeight(.medium)
                .accessibilityLabel(favorites.contains(movie) ? "Remove from Favorites" : "Add to Favorites")
                .shadow(color: .shadow, radius: 3)
        }
    }
}

#Preview {
    FavoritesButtonView(movie: .example)
        .environmentObject(Persistence())
}
