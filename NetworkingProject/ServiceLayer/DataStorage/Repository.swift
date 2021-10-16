//  Repository.swift
//  NetworkingProject

import Foundation

protocol RepositoryProtocol: AnyObject {
    associatedtype Entity
//    func get(predicate: NSPredicate) -> [Entity]
    func get() -> [Entity]
    func save(object: [Entity])
    func removeAll()
}

/// Repository
class Repository<DataBaseEntity>: RepositoryProtocol {
    typealias Entity = DataBaseEntity

    // MARK : - Public methods

    func get() -> [Entity] {
        fatalError("")
    }

    func getDetail(format: String, filter: CVarArg) -> [Entity] {
        fatalError("")
    }

    func save(object: [Entity]) {
        fatalError("")
    }

    func removeAll() {}
}
