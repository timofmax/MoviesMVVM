//
//  DetailPresenter.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 05.10.2021.
//

import Foundation

protocol DetailMovieViewProtocol: AnyObject {
    func success()
}

protocol DetailMoviePresenterProtocol: AnyObject {
    func fetchDetails()
    var movieDetails: MovieDetail? { get set }
}

final class DetailsPresenter: DetailMoviePresenterProtocol {
    var movieDetails: MovieDetail?
    var movieAPIService: MovieAPIServiceProtocol?
    var id: Int?
    var router: RouterProtocol?
    var dataStorageService: DataStorageServiceProtocol?
    private weak var view: DetailMovieViewProtocol?

    init(view: DetailMovieViewProtocol, id: Int, networkService: MovieAPIServiceProtocol, router: RouterProtocol, dataStorageService: DataStorageServiceProtocol?) {
        self.dataStorageService = dataStorageService
        self.view = view
        self.id = id
        movieAPIService = networkService
        self.router = router
    }

    func fetchDetails() {
        guard let movieAPIService = movieAPIService else { return }
        movieAPIService.fetchDataDetail(id: id) { movieDetail, error in
            if error != nil {
                print(error.debugDescription)
                return
            }
            self.movieDetails = movieDetail
            self.view?.success()
        }
    }
}
