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
    @Binding var path: [AppNavigation]

    var body: some View {
        BaseView(title: title) {
            if let movies = movies, !movies.isEmpty {
                GridView(movies: movies,path: $path)
            } else {
               EmptyStateView()
            }
        }
    }
}

#Preview {
    TabContent(movies: [.example], title: "Trending", path: .constant([])) 
        .environmentObject(Persistence())
}
