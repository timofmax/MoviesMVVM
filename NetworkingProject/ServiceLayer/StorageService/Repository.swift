//
//  Repository.swift
//  MoviesTest
//
//  Created by Timofey Privalov on 11.10.2021.
//

import Foundation

protocol DatabaseProtocol {
    func get() -> [Movie]
    func add(object: [Movie])
    func remove(id: Int)
}

final class Repository {
    var dataBase: DatabaseProtocol
    init(dataBase: DatabaseProtocol) {
        self.dataBase = dataBase
    }

    func getMovie() -> [Movie] {
        return dataBase.get()
    }

    func save(obj: [Movie]) {
        dataBase.add(object: obj)
    }

    func deleteAll(obj: Movie) {
        dataBase.remove(id: obj.id)
    }
}
