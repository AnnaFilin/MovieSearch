//
//  TabContent.swift
//  MovieSearch
//
//  Created by Anna Filin on 08/12/2024.
//

import SwiftUI

struct TabContent: View {
    let movies: [Movie]?
    let title: String
    @Binding var selectedTab: Int

    var body: some View {
        NavigationStack {
            BaseView(title: title) {
                if let movies = movies, !movies.isEmpty {
                    ScrollView {
                        VStack(spacing: AppSpacing.itemSpacing/2) {
                            ForEach(movies, id: \.self.id) { movie in
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
    TabContent(movies: [.example], title: "Trending", selectedTab: .constant(2))
        .environmentObject(Persistence())
}
