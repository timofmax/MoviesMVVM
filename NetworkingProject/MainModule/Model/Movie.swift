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
@objc final class Movie: Object, Codable {
    /// id фильма
    @objc dynamic var id = Int()
    /// обзор фильма
    @objc dynamic var overview = String()
    /// постер фильма
    @objc dynamic var posterPath = String()
    /// название фильма
    @objc dynamic var title = String()
    /// рейтинг фильма
    @objc dynamic var voteAverage = Double()
    /// уникальный id для db
    override class func primaryKey() -> String? {
        "id"
    }
}
