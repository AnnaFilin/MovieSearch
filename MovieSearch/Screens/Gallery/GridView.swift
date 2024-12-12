//
//  GridView.swift
//  MovieSearch
//
//  Created by Anna Filin on 12/12/2024.
//

import SwiftUI

struct GridView: View {
    let movies: [Movie]
    @Binding var path: [AppNavigation]
    
    let columns = [
        GridItem(.adaptive(minimum: 150))
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 16) {
                ForEach(movies) {movie in
                    
                    Button {
                        path.append(.movieDetails(movie: movie))
                    } label: {
                        MovieCard(movie: movie, width: 175, height: 280)
                    }
                }
            }
            .padding(.horizontal, AppSpacing.horizontal)
        }
    }
}

#Preview {
    GridView(movies: [.example], path: .constant([]))
        .environmentObject(Persistence())
}



