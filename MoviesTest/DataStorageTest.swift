//
//  DataStorageTest.swift
//  MoviesTest
//
//  Created by Timofey Privalov on 17.10.2021.
//

@testable import NetworkingProject
import RealmSwift
import XCTest
//final class RealmRepository<RealmEntity: Object>: Repository<RealmEntity>

final class MockRealmRepository<RealmEntity: Object>: Repository<RealmEntity> {
    typealias Entity = RealmEntity

    override func save(object: [Entity]) {
        do {
            let config = Realm.Configuration(deleteRealmIfMigrationNeeded: true)

            let realm = try Realm(configuration: config)
            try realm.write {
                realm.add(object, update: .all)
            }
        } catch {
            print(error)
        }
    }

    override func get() -> [Entity] {
        do {
            let realm = try Realm()
            let realmObjects = realm.objects(Entity.self)
            var entityArray: [Entity] = []
            realmObjects.forEach {
                entityArray.append($0)
            }
            return entityArray
        } catch {
            return []
        }
    }
}

@objc final class MockMovieRealmTest: Object, Codable {
    /// id фильма
    @objc dynamic var id: Int = Int()
    /// оригинальное название фильма
    @objc dynamic var originalTitle: String?
    /// уникальный ключ для дб
    override class func primaryKey() -> String? {
        "id"
    }
}

final class MockRealmTest: XCTestCase {
    var movies: [MockMovieRealmTest] = []

    func testSaveMovie() {
        let movieOne = MockMovieRealmTest()
        movieOne.id = 44
        movieOne.originalTitle = "Fizz Movie"

        let movieTwo = MockMovieRealmTest()
        movieTwo.id = 46
        movieTwo.originalTitle = "Buzz Movie"

        movies = [movieOne, movieTwo]

        let repository = MockRealmRepository<MockMovieRealmTest>()

        repository.save(object: movies)

        let savedMovies = repository.get()
        XCTAssertEqual(savedMovies.count, 2)
    }
}
