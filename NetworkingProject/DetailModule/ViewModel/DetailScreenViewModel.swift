//
//  DetailScreenViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
//

import Foundation

typealias VoideHandler = (()->())

protocol DetailScreenViewModelProtocol {
    var movies: ((MovieDetails?)->())? { get set }
    var updateViewData: VoideHandler? { get set }
    func fetchMoviesFromViewModel(id: Int)
    var movieDetail: MovieDetails? { get set }
    var id: Int { get set }
}

final class DetailViewModel: DetailScreenViewModelProtocol {
    //MARK: - Public Properties
    var movieDetail: MovieDetails?
    var movies: ((MovieDetails?)->())?
    var updateViewData: (() -> ())?
    var movieAPIService: MovieAPIServiceProtocol = MovieAPIService()
    var id: Int

    init(movieID: Int) {
        self.id = movieID
    }

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
