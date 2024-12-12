//
//  MovieDetailsBackground.swift
//  MovieSearch
//
//  Created by Anna Filin on 12/12/2024.
//

import SwiftUI

struct MovieDetailsBackground<Content: View>: View {
        let movie: Movie
        let content: Content
        
        init(movie: Movie,  @ViewBuilder content: () -> Content) {
            self.movie = movie
            self.content = content()
        }
        
        var body: some View {
            ZStack {
                if let posterPath = movie.posterPath {
                    ImageView(url: posterPath, width: nil, height: nil, opacity: 1.0, fillContentMode: true)
                        .ignoresSafeArea()
                }
                
                LinearGradient(
                    gradient: Gradient(colors: [.background.opacity(0.001), .background.opacity(0.01), .background.opacity(0.6), .background.opacity(0.9)]),
                    startPoint: .top,
                    endPoint: .center
                )
                .ignoresSafeArea()
                
                VStack {
                    content
                        .foregroundColor(.white)
                }
            }
        }
    }

  



#Preview {
    MovieDetailsBackground(movie: .example) {
        MovieDetailsView(movie: .example)
    }
    .environmentObject(Persistence())
}
