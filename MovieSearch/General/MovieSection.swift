//
//  MovieSection.swift
//  MovieSearch
//
//  Created by Anna Filin on 22/12/2024.
//

import SwiftUI

struct MovieSection: View {
    let movies: [Movie]
    let title: String
    @Binding var path: [AppNavigation]
    let seeAll: String = "See all"
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(title)
                    .font(.system(size: 20, weight: .light, design: .default))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .lineLimit(nil)
                
                Spacer()
                
                Button(seeAll) {
                    path.append(.tabContent(movies: movies, title: title))
                }
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.shadow)
                .padding(.trailing, 12)
            }
            .padding(.horizontal, AppSpacing.horizontal)
        }
        ScrollView(.horizontal, showsIndicators: false) {
            
            HorizontalScroll(items: movies,  horizontalInset: AppSpacing.horizontal)  { movie in
                
                Button {
                    path.append(.movieDetails(movie: movie))
                } label: {
                    MovieCard(movie: movie)
                }
            }
            .shadow(color: .lilac.opacity(0.2), radius: 20, x: 5, y: 10)
//            .padding(.horizontal, AppSpacing.horizontal)
        }
    }
    
}

#Preview {
    MovieSection(movies: [.example], title: "Popular", path: .constant([]))
        .environmentObject(Persistence())
        .environmentObject(ViewModel(movieService: MovieService()))
}
