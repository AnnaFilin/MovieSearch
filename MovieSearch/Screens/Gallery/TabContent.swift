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
//    @Binding var selectedTab: Int

    var body: some View {
        NavigationStack {
//        VStack {
            
            BaseView(title: title) {
                if let movies = movies, !movies.isEmpty {
                    GridView(movies: movies)
                } else {
                   EmptyStateView() //selectedTab: $selectedTab
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
    TabContent(movies: [.example], title: "Trending") //, selectedTab: .constant(2)
        .environmentObject(Persistence())
}
