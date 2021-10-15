// MovieData.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

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
//@objc final class Movie: Object, Codable {
//
//
//}

///Movie
struct Movie: Decodable {
    let overview: String
    let posterPath: String
    let title: String
    let voteAverage: Double
    let id: Int
}

