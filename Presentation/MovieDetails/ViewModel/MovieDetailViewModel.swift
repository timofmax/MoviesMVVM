//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    var updateViewData: VoidHandler? { get set }
    func fetchMoviesFromViewModel(id: Int)
    var movieDetail: MovieDetailRealm? { get set }
    var id: Int? { get set }
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public Properties
    var movieDetail: MovieDetailRealm?
    var updateViewData: VoidHandler?
    var id: Int?
    // MARK: - Private Properties
    private var movieAPIService: MovieAPIServiceProtocol?
    private var repository: Repository<MovieDetailRealm>?
    // MARK: - Lifecycle
    init(movieAPIService: MovieAPIServiceProtocol, repository: Repository<MovieDetailRealm>?) {
        self.movieAPIService = movieAPIService
        self.repository = repository
    }

    // MARK: - Public Methods
    func fetchMoviesFromViewModel(id: Int) {
        fetchDetailData(filmID: id)
    }

    // MARK: - Private Methods
    private func fetchDetailData(filmID: Int) {
        let requestPredicate = NSPredicate(format: "id = \(filmID)")

        let cacheMovie = repository?.getDetail(predicate: requestPredicate)

        if !(cacheMovie?.isEmpty ?? true) {
            guard let cacheMovie = cacheMovie else { return }
            movieDetail = cacheMovie.first
            return
        }

        movieAPIService?.fetchDetailsFromAPI(id: filmID) { [ weak self ] result in
            DispatchQueue.main.async {
                result?.id = filmID
                self?.movieDetail = result
                guard let movies = result else { return }
                self?.repository?.save(object: [movies])
                self?.updateViewData?()
            }
        }
    }
}
