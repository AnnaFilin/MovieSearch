//
//  GenresView.swift
//  MovieSearch
//
//  Created by Anna Filin on 26/11/2024.
//

import SwiftUI

struct GenreItemView: View {
    let genre: String
 
    var body: some View {
        Text(genre)
            .font(.callout.bold())
            .opacity(0.7)
            .multilineTextAlignment(.center)
            .lineLimit(nil)
            .padding(AppSpacing.itemSpacing)
            .background(Color.theme.opacity(0.2))
            .cornerRadius(10)
    }
    
}


struct GenresView: View {
    let movieGenres: [String]

    private let threshold = 5
    
    var body: some View {
        if movieGenres.count <= threshold {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: AppSpacing.itemSpacing) {
                    ForEach(movieGenres, id: \.self) { genre in
                        GenreItemView(genre: genre)
                    }
                }
            }
        } else {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80), spacing: AppSpacing.itemSpacing)], spacing: AppSpacing.itemSpacing) {
                ForEach(movieGenres, id: \.self) { genre in
                    GenreItemView(genre: genre)
                }
            }
        }
    }
}

#Preview {
    GenresView(movieGenres: ["Fantasy", "Animation", "Comedy"])
}
