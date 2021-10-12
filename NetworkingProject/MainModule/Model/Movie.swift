// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

/// ViewData
enum ViewData {
    case loading
    case loaded([Movie])
    case failure(description: String?, onReload: () -> ())
}

/// MoviesFavorite
struct IncomingJson: Decodable {
    let results: [Movie]
}

/// MoviesFavorite
struct Movie: Decodable {
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
