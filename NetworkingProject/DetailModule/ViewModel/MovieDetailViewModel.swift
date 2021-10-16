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
//    private var movieAPIService: MovieAPIServiceProtocol = MovieAPIService
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
        guard let movieAPIService = movieAPIService else { return }
        movieAPIService.fetchDetailsFromAPI(id: filmID) { [ weak self ] result in
            self?.movieDetail = result
            self?.updateViewData?()
        }
    }

}
