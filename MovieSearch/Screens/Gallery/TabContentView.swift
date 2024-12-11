//
//  TabContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct TabContentView: View {
//    let movies: [Movie]?
    @EnvironmentObject private var favorites: Persistence

    let title: String
    @Binding var selectedTab: Int

    var body: some View {
        NavigationStack {
            BaseView(title: title) {
                if !favorites.favoritedMovies.isEmpty {
                    ScrollView {
                        VStack(spacing: AppSpacing.itemSpacing/2) {
                            ForEach(Array(favorites.favoritedMovies), id: \.self.id) { movie in
                                NavigationLink(value: movie) {
                                    MovieView(movie: movie)
                                }
                            }
                        }
                        .padding(.top,AppSpacing.vertical)
                    }
                } else {
                   EmptyStateView(selectedTab: $selectedTab)
                }
            }
            .navigationDestination(for: Movie.self) { selection in
                MovieDetailsView(movie: selection)
            }
        }
        .tint(.theme)
    }
}

#Preview {
    TabContentView( title: "Favorites", selectedTab: .constant(2))
//    TabContentView(movies: [.example], title: "Trending", selectedTab: .constant(2))

        .environmentObject(Persistence())
}
