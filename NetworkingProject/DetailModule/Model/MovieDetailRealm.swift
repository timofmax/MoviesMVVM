// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

///  - MovieDetails


@objc final class MovieDetailRealm: Object, Codable {
    // MARK: - Public Properties

    /// id фильма
    @objc dynamic var id: Int = Int()
    /// бюджет фильма
    @objc dynamic var budget = Int()
    /// зарабаток фильма
    @objc dynamic var revenue = Int()
    /// описание фильма
    @objc dynamic var overview: String?
    /// путь к картинке фильма
    @objc dynamic var backdropPath: String?
    /// оригинальное название фильма
    @objc dynamic var originalTitle: String?
    /// путь к постеру фильма
    @objc dynamic var posterPath: String?
    /// дата выхода фильма
    @objc dynamic var releaseDate: String?
    /// уникальный ключ для дб
    override class func primaryKey() -> String? {
        "id"
    }
}

