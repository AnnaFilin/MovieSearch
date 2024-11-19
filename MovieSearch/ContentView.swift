//
//  ContentView.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/11/2024.
//

import SwiftUI

struct ContentView: View {
    @State private var movies: [Movie] = []
    @State private var errorMessage: String?
    @State private var searchInput = "Br"

    private let movieApiService = MoviesAPIService()
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(red: 0.15, green: 0.16, blue: 0.12)
                    .ignoresSafeArea()

                ScrollView {
                    VStack {
                        Section {
           
                            TextField("Search movie", text: $searchInput)
                                .font(.body)
                                .padding()
                                .background(Color(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 0.2662717301)))
                                .cornerRadius(5)
//                                .onChange(of: coffeeVM.searchText) { text in
//                                    coffeeVM.filterContent()
//                                }
                        }
                        .padding()
                        
                        
                        ForEach(movies, id: \.self.id) { movie in
                            NavigationLink(value: movie) {
                                MovieView(movie: movie)
                            }
                        }
                    }
                    
                 
                }
            }
            .navigationTitle("Movies Search")
            .navigationDestination(for: Movie.self) { selection in
                MovieDetailsView(movie: selection)
            }
            .onAppear(perform: fetchMovies)
            .preferredColorScheme(.dark)
        }
    }
        
        func fetchMovies() {
            movieApiService.fetchMovies { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let movies):
                        self.movies = movies
                        print(movies[0])
                        self.errorMessage = nil
                    case .failure(let error):
                        self.errorMessage = error.localizedDescription
                    }
                }
            }
        }
    
}

#Preview {
    ContentView()
}

//
//                VStack {
//                    if let errorMessage = errorMessage {
//                        Text("Error: \(errorMessage)")
//                            .foregroundColor(.red)
//                            .padding()
//                    } else if movies.isEmpty {
//                        Text("No movies found.")
//                            .padding()
//                    } else {

//                                AsyncImage(url: URL(string: movie.poster_path), scale: 2) { image in
//                                        image
////                                            .resizable()
////                                            .scaledToFit()
//                                        .foregroundColor(.white)
//                                                                    .frame(width: 85, height: 85)
//                                                                    .background(Color.blue)
//
