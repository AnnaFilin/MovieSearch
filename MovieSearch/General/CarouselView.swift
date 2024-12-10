//
//  CarouselView.swift
//  MovieSearch
//
//  Created by Anna Filin on 09/12/2024.
//

import SwiftUI

struct CarouselView: View {
    let movies: [Movie]
    @State private var selectedIndex: Int = 0
    let horizontalInset: CGFloat
    
    init(movies: [Movie], selectedIndex: Int = 2, horizontalInset: CGFloat = AppSpacing.horizontal) {
        self.movies = movies
        self.selectedIndex = selectedIndex
        self.horizontalInset = horizontalInset
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {
                ForEach(movies.indices, id: \.self) { index in
                    FavoriteMovieCard(movie: movies[index])
                }
            }
            .frame(height: UIScreen.main.bounds.width * 1.4)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) 
            
            HStack(spacing: 8) {
                ForEach(movies.indices, id: \.self) { index in
                    Circle()
                        .fill(index == selectedIndex ? Color.gray : Color.gray.opacity(0.4))
                        .frame(width: 20, height: 20)
                        .padding(.bottom, AppSpacing.vertical * 3)
                }
            }
            .padding(.horizontal, horizontalInset)
        }
    }
}

#Preview {
    CarouselView(movies: [.example], selectedIndex: 2 )
}
