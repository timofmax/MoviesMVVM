//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

protocol DetailScreenViewModelProtocol {
    var movies: ((MovieDetails?)->())? { get set }
    var updateViewData: (() -> ())? { get set }
    func fetchMoviesFromViewModel(id: Int)
    var movieDetail: MovieDetails? { get set }
}

final class DetailViewModel: DetailScreenViewModelProtocol {
    //MARK: - Public Properties
    var movieDetail: MovieDetails?
    var movies: ((MovieDetails?)->())?
    var updateViewData: (() -> ())?
    var movieAPIService: MovieAPIServiceProtocol = MovieAPIService()

    //MARK: - Public Methods
    func fetchMoviesFromViewModel(id: Int) {
        fetchDetailData(filmID: id)
    }

    //MARK: - Private Methods
    private func fetchDetailData(filmID: Int) {
        movieAPIService.fetchDetailsFromAPI(id: filmID) { [ weak self ] result in
            self?.movieDetail = result
            self?.updateViewData?()
        }
    }
}
