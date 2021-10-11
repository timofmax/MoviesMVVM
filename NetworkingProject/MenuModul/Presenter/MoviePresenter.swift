//
//  MenuPresenter.swift
//  NetworkingProject
//

import Foundation

protocol MovieViewProtocol: AnyObject {
    func success()
}

protocol MoviePresenterProtocol: AnyObject {
    var moviesList: [Movie]? { get set }
    func fetchMovies()
    func tapOnTheCell(moveId: Int)
}

/// MenuPresenter
final class MoviePresenter: MoviePresenterProtocol {
    var moviesList: [Movie]?
    private var router: RouterProtocol?
    private var movieAPIService: MovieAPIServiceProtocol!
    private weak var view: MovieViewProtocol?
    init(view: MovieViewProtocol, networkService: MovieAPIServiceProtocol, moviesList: [Movie], router: RouterProtocol) {
        self.view = view
        self.moviesList = moviesList
        movieAPIService = networkService
        self.router = router
    }

    func tapOnTheCell(moveId: Int) {
        router?.showMoviewDetail(movieId: moveId)
    }

    func fetchMovies() {
        movieAPIService.downloadMovies { movies, error in
            if error != nil {
                print(error.debugDescription)
                return
            }
            self.moviesList = movies
            self.view?.success()
        }
    }
}
