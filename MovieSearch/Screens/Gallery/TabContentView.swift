//
//  TabContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct TabContentView: View {
    let movies: [Movie]?
    let title: String
    @Binding var selectedTab: Int

    var body: some View {
        NavigationStack {
            BaseView(title: title) {
                if let movies = movies, !movies.isEmpty {
                    ScrollView {
                        ForEach(movies, id: \.self.id) { movie in
                            NavigationLink(value: movie) {
                                MovieView(movie: movie)
                            }
                        }
                    }
                } else {
                   EmptyStateView(selectedTab: $selectedTab)
                }
            }
            .navigationDestination(for: Movie.self) { selection in
                MovieDetailsView(movie: selection)
            }
        }
        .tint(.shadow)
    }
}

#Preview {
    TabContentView(movies: [], title: "Trending", selectedTab: .constant(2))
        .environmentObject(Persistence())
}
