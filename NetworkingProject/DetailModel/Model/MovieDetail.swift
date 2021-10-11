// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import CoreData
import Foundation

///  - MovieDetails
struct MovieDetail: Codable {
    let backdropPath: String
    let budget: Int
    let id: Int?
    let overview: String
    let originalTitle: String
    let posterPath: String
    let releaseDate: String
    let revenue: Int
}

@objc(CoreDescription)
class CoreDescription: NSManagedObject {
    @NSManaged var backdropPath: String
    @NSManaged var budget: Int
    @NSManaged var id: Int
    @NSManaged var overview: String
    @NSManaged var originalTitle: String
    @NSManaged var posterPath: String
    @NSManaged var releaseDate: String
    @NSManaged var revenue: Int
}
