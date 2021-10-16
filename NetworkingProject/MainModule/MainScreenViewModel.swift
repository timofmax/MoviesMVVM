//  Created by Timofey Privalov on 12.10.2021.
// Testing git stash!

import Foundation

typealias VoidHandler = (() -> ())

protocol MainScreenViewModelProtocol {
    func getData()
    var movies: [MovieRealm]? { get set }
    var updateViewData: (()->())? { get set }
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties
    var updateViewData: (()->())?
    var movies: [MovieRealm]? = []

    // MARK: - Private Properties
    private var movieAPIService: MovieAPIServiceProtocol?
    private var repository: Repository<MovieRealm>?

    // MARK: - Lifecycle Method
    init(movieAPIService: MovieAPIServiceProtocol, repository: Repository<MovieRealm>?) {
        self.movieAPIService = movieAPIService
        self.repository = repository
    }

    // MARK: - Public Method
    func getData() {
        fetchMovies()
    }

    // MARK: - Private Method
    private func fetchMovies() {
        let savedMovies = repository?.get()
        guard let movies = savedMovies else { return }
        if !(movies.isEmpty) {
            updateViewData?()
            return
        }

        movieAPIService?.fetMovies { [ weak self ] moviesFromApiService in
            DispatchQueue.main.async {
                self?.movies = moviesFromApiService
                self?.repository?.save(object: moviesFromApiService)
                self?.updateViewData?()
            }
        }

        


    }
 }
