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
    let width: CGFloat
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum :width / 2.5))], spacing: AppSpacing.itemSpacing) {

            ForEach(movies) {movie in
                    
                    Button {
                        path.append(.movieDetails(movie: movie))
                    } label: {

                        MovieCard(movie: movie, path: $path, width:width / 2.5, height: 280)
                            .padding(.vertical, AppSpacing.vertical)
                    }
                }
            }
            .padding(.horizontal, AppSpacing.horizontal)
        }
    }
}

#Preview {
    GridView(movies: [.example], path: .constant([]), width: UIScreen.main.bounds.width )
        .environmentObject(Persistence())
}



