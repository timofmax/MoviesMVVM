//
//  CoreDataMovies.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 10.10.2021.
//

import CoreData
import Foundation

final class CoreDataMovies: DatabaseProtocol {
    // MARK: - Private Properties

    private let coreDataService = CoreDataService.shared

    // MARK: - Public methods

    func get() -> [Movie] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CoreMovie.self))
        guard let result = try? coreDataService.context.fetch(fetchRequest) as? [CoreMovie] else { return [] }

        let movies = result.map {
            Movie(
                adult: $0.adult,
                overview: $0.overview,
                posterPath: $0.posterPath,
                backdropPath: $0.backdropPath,
                title: $0.title,
                voteAverage: $0.voteAverage,
                id: $0.id,
                revenue: $0.revenue,
                releaseDate: $0.releaseDate,
                budget: $0.budget
            )
        }
        return movies
    }

    func add(object: [Movie]) {
        for movie in object {
            let movieModel = CoreMovie(context: coreDataService.context)
            movieModel.id = movie.id ?? 0
            movieModel.title = movie.title
            movieModel.posterPath = movie.posterPath
            movieModel.overview = movie.overview
            movieModel.voteAverage = movie.voteAverage ?? 0
            movieModel.budget = movie.budget ?? 0.0
        }
        coreDataService.saveContext()
    }

    func getDescription(id _: Int) -> [MovieDetail] {
        []
    }

    func addDescription(object _: [MovieDetail], id _: Int) {}
    func remove(id _: Int) {}

    func removeAll() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: String(describing: CoreMovie.self))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        _ = try? coreDataService.context.execute(deleteRequest)
        coreDataService.saveContext()
    }
}
