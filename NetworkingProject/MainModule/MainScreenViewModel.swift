//
//  MainViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
// Testing git stash!

import Foundation

protocol MainScreenViewModelProtocol {
    func getData()
    var movies: [Movie] { get set }
    var updateView: (() -> ())? { get set }
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties
    var updateView: (() -> ())?
    var movies: [Movie] = []

    // MARK: - Private Properties
    private var movieAPIService: MovieAPIServiceProtocol?

    // MARK: - Lifecycle Method
    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    // MARK: - Public Method
    func getData() {
        fetMovies()
    }

    // MARK: - Private Method
    private func fetMovies() {
        movieAPIService?.fetMovies { [ weak self ] moviesFromApiService in
            self?.movies = moviesFromApiService
            self?.updateView?()
        }
    }
 }
