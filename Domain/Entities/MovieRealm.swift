// MovieData.swift
// Copyright © timofmax. All rights reserved.

import Foundation
import RealmSwift

/// ViewData
enum ViewData {
    case loading
    case loaded([MovieRealm])
    case failure(description: String?, onReload: () -> ())
}

/// MoviesFavorite
struct IncomingJson: Decodable {
    let results: [MovieRealm]
}

/// MoviesFavorite
@objc final class MovieRealm: Object, Codable {
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
