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

    var body: some View {
        ZStack(alignment: .bottom) {
            TabView(selection: $selectedIndex) {
                ForEach(movies.indices, id: \.self) { index in
                    FavoriteMovieCard(movie: movies[index])
                }
            }
            .frame(height: UIScreen.main.bounds.width * 1.4)
            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never)) // Hides default dots
            
            HStack(spacing: 8) {
                ForEach(movies.indices, id: \.self) { index in
                    Circle()
                        .fill(index == selectedIndex ? Color.gray : Color.gray.opacity(0.4))
                        .frame(width: 20, height: 20)
                        .padding(.bottom, AppSpacing.vertical * 3)
                }
            }
        }
    }
}

#Preview {
    CarouselView(movies: [.example])
}
