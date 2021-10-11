//
//  DataStorageService.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 07.10.2021.
//

import CoreData
import Foundation

protocol DataStorageServiceProtocol {
    func save(object: [Movie])
    func get() -> [Movie]
}

// DataStorageService
final class DataStorageService: DataStorageServiceProtocol {
    private let repository = Repository(dataBase: CoreDataMovies())

    func save(object: [Movie]) {
        repository.save(obj: object)
    }

    func get() -> [Movie] {
        return repository.getMovie()
    }
}
