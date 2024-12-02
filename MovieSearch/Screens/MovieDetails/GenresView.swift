//
//  GenresView.swift
//  MovieSearch
//
//  Created by Anna Filin on 26/11/2024.
//

import SwiftUI

struct GenresView: View {
    let movieGenres: [String]
    
    let genres: [String: String] = [
            "Action": "bolt",
            "Comedy": "theatermasks",
            "Drama": "eyeglasses",
            "Sci-Fi": "sparkles",
            "Horror": "moon.stars",
            "Animation": "paintbrush",
            "Romance": "heart.fill",
            "Thriller": "magnifyingglass",
            "Fantasy": "wand.and.stars",
            "Documentary": "doc.text"
        ]
    
    let columns = [
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15),
            GridItem(.flexible(), spacing: 15)
        ]
    
    var body: some View {
        LazyVGrid(columns: columns, spacing: 15) {
            ForEach(movieGenres, id: \.self) { genre in
                if let icon = genres[genre] {
                    VStack {
                        Image(systemName: icon)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.orange)
                        Text(genre)
                            .font(.caption)
                            .multilineTextAlignment(.leading)
                    }
                }
            }
        }
    }
}

#Preview {
    GenresView(movieGenres: ["Fantasy", "Animation", "Comedy"])
}
