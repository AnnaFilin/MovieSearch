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
    
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: geometry.size.width / 2.5))], spacing: AppSpacing.itemSpacing) {
                    ForEach(movies) {movie in
                        
                        Button {
                            path.append(.movieDetails(movie: movie))
                        } label: {
                            MovieCard(movie: movie, width: geometry.size.width / 2.5, height: 280)
                        }
                    }
                }
                .padding(.horizontal, AppSpacing.horizontal)
            }
        }
    }
}

#Preview {
    GridView(movies: [.example], path: .constant([]))
        .environmentObject(Persistence())
}



