//
//  TabContent.swift
//  MovieSearch
//
//  Created by Anna Filin on 08/12/2024.
//

import SwiftUI

struct MoviesGridView: View {
    let movies: [Movie]?
    let title: String
    @Binding var path: [AppNavigation]
    let screenWidth: CGFloat

    var body: some View {
        BaseView(title: title) {
            if let movies = movies, !movies.isEmpty {
                GridView(movies: movies,path: $path, width: screenWidth)
                    .padding(.top, 10)
            } else {
               EmptyStateView()
            }
        }
    }
}

#Preview {
    MoviesGridView(movies: [.example], title: "Trending", path: .constant([]), screenWidth: UIScreen.main.bounds.width) 
        .environmentObject(Persistence())
}
