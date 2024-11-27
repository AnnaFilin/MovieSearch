//
//  TabContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 24/11/2024.
//

import SwiftUI

struct TabContentView: View {
    let movies: [Movie]
    let title: String

    var body: some View {
        NavigationStack {
            LayoutView(title: title) {
                ScrollView {
                    ForEach(movies, id: \.self.id) { movie in
                        NavigationLink(value: movie) {
                            MovieView(movie: movie)
                        }
                    }
                }
            }
            .navigationDestination(for: Movie.self) { selection in
                MovieDetailsView(movie: selection)
            }
        }
        .tint(.orange)
    }
}

#Preview {
    let movies = [Movie(
        id: 402431,
           title: "Wicked",
           original_title: "Wicked",
           original_language: "en",
           overview: """
               Elphaba, an ostracized but defiant girl born with green skin, and Galinda, 
               a privileged aristocrat born popular, become extremely unlikely friends 
               in the magical Land of Oz. As the two girls struggle with their opposing 
               personalities, their friendship is tested as both begin to fulfil their destinies 
               as Glinda the Good and The Wicked Witch of the West.
               """,
           poster_path: "/c5Tqxeo1UpBvnAc3csUm7j3hlQl.jpg",
           backdrop_path: "/uVlUu174iiKhsUGqnOSy46eIIMU.jpg",
           genre_ids: [18, 14, 10749],
           release_date: "2024-11-20",
           popularity: 927.236,
           vote_average: 7.5,
           vote_count: 30,
           adult: false,
           video: false
    )]
    
    TabContentView(movies: movies, title: "Trending")
//        .environmentObject(favorites)
}
