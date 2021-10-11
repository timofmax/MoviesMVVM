//
//  CoreDataService.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 08.10.2021.
//

import CoreData
import Foundation

final class CoreDataService {
    // MARK: - Public Properties

    var context: NSManagedObjectContext {
        persistentContainer.viewContext
    }

    static let shared = CoreDataService()

    // MARK: - Private Properties

    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "DataStorage")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Initializers

    private init() {}

    // MARK: - Public methods

    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
