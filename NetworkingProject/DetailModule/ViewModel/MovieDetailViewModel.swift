//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

typealias VoideHandler = (()->())

protocol MovieDetailViewModelProtocol {
    var updateViewData: VoideHandler? { get set }
    func fetchMoviesFromViewModel(id: Int)
    var movieDetail: MovieDetails? { get set }
    var id: Int { get set }
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    // MARK: - Public Properties
    var movieDetail: MovieDetails?
    var updateViewData: (() -> ())?
    var id: Int
    // MARK: - Private Properties
    private var movieAPIService: MovieAPIServiceProtocol = MovieAPIService()

    // MARK: - Lifecycle
    init(movieID: Int) {
        self.id = movieID
    }

    // MARK: - Public Methods
    func fetchMoviesFromViewModel(id: Int) {
        fetchDetailData(filmID: id)
    }

    // MARK: - Private Methods
    private func fetchDetailData(filmID: Int) {
        movieAPIService.fetchDetailsFromAPI(id: filmID) { [ weak self ] result in
            self?.movieDetail = result
            self?.updateViewData?()
        }
    }

}
