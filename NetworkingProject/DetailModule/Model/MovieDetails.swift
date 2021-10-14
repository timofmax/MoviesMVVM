// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation

///  - MovieDetails
struct MovieDetails: Decodable {
    let backdropPath: String
    let budget: Int
    let id: Int
    let overview: String
    let originalTitle: String
    let posterPath: String
    let releaseDate: String
    let revenue: Int
}
