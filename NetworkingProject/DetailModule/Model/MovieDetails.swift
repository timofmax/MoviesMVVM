// MovieDetails.swift
// Copyright © RoadMap. All rights reserved.

import Foundation
import RealmSwift

///  - MovieDetails
/*
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
*/


@objc final class MovieDetails: Object, Codable {
    // MARK: - Public Properties

    /// id фильма
    @objc dynamic var id: Int
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
    override class func primaryKey() -> String {
        "id"
    }
}

