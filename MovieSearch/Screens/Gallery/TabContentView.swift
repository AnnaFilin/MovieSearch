//
//  TabContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct TabContentView: View {
    @EnvironmentObject private var favorites: Persistence
    
    let title: String
    @Binding var selectedTab: Int
    @Binding var path: [AppNavigation]
    let screenWidth: CGFloat
    
    var body: some View {
        BaseView(title: title) {
            if !favorites.favoritedMovies.isEmpty {
                GridView(movies: Array(favorites.favoritedMovies), path: $path, width: screenWidth)
                    .id(favorites.favoritedMovies.count)
            } else {
                EmptyStateView()
            }
        }
        .onAppear {
            path = [] 
        }
    }
}

#Preview {
    TabContentView( title: "Favorites",selectedTab: .constant(2),  path: .constant([.movieDetails(movie: .example)]), screenWidth: UIScreen.main.bounds.width)
        .environmentObject(Persistence())
}
