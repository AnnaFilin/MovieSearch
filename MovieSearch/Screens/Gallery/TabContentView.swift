//
//  TabContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct TabContentView: View {
    let movies: [Movie]
    let title: String

    var body: some View {
        NavigationStack {
            BaseView(title: title) {
                ScrollView {
                    ForEach(movies, id: \.self.id) { movie in
                        NavigationLink(value: movie) {
                            MovieView(movie: movie)
                        }
                    }
                }
            }
            .navigationDestination(for: Movie.self) { selection in
                MovieDetailsView(movie: selection)
            }
        }
        .tint(.orange)
    }
}

#Preview {
//    let movies =
    
    TabContentView(movies: [.example], title: "Trending")
//        .environmentObject(favorites)
}
