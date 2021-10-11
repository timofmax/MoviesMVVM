//
//  Result.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 04.10.2021.
//

import CoreData
import Foundation

/// MoviesFavorite
struct MoviesFavorite: Decodable {
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
    var id: Int
    let revenue: Double?
    let releaseDate: String?
    let budget: Double?
}

@objc(CoreMovie)
class CoreMovie: NSManagedObject {
    @NSManaged var adult: Bool
    @NSManaged var overview: String
    @NSManaged var posterPath: String
    @NSManaged var backdropPath: String
    @NSManaged var title: String
    @NSManaged var voteAverage: Double
    @NSManaged var id: Int
    @NSManaged var revenue: Double
    @NSManaged var releaseDate: String?
    @NSManaged var budget: Double
}
