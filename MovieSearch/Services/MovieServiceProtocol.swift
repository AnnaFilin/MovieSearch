//
//  MovieSearchProtocol.swift
//  MovieSearch
//
//  Created by Anna Filin on 18/12/2024.
//

import Foundation

protocol MovieServiceProtocol {
    func fetchTrendingMovies() async throws -> [Movie]
    func fetchPopularMovies() async throws -> [Movie]
    func fetchTopRatedMovies() async throws -> [Movie]
    func searchMovies(query: String) async throws -> [Movie]
    func fetchMoviesByGenre(genreID: Int) async throws -> [Movie]
    func fetchMovieDetails(movieId: Int) async throws -> MovieDetail
    func fetchCastDetails(movieId: Int) async throws -> [CastMember]
    func fetchMovieImages(movieId: Int) async throws -> [MovieImage]
}
