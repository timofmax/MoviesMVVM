// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// MoviesFavorite
struct MoviesFavorite: Decodable {
    let results: [Result]
}

/// MoviesFavorite
struct Result: Decodable {
    let adult: Bool
    let overview: String
    let posterPath: String
    let backdropPath: String
    let title: String
    let voteAverage: Double
    let id: Int
    let revenue: Double?
    let releaseDate: String?
    let budget: Double?
}
