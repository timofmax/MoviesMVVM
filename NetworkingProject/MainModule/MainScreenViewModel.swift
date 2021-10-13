//
//  MainViewModel.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 12.10.2021.
// Testing git stash!

import Foundation

typealias VoidHandler = (() -> ())

protocol MainScreenViewModelProtocol {
    func getData()
    var movies: [Movie] { get set }
    var updateView: VoidHandler? { get set }
}

final class MainScreenViewModel: MainScreenViewModelProtocol {
    // MARK: - Public Properties
    var updateView: VoidHandler?
    var movies: [Movie] = []

    // MARK: - Private Properties
    private var movieAPIService: MovieAPIServiceProtocol?

    // MARK: - Lifecycle Method
    init(movieAPIService: MovieAPIServiceProtocol) {
        self.movieAPIService = movieAPIService
    }

    // MARK: - Public Method
    func getData() {
        fetchMovies()
    }

    // MARK: - Private Method
    private func fetchMovies() {
        movieAPIService?.fetMovies { [ weak self ] moviesFromApiService in
            self?.movies = moviesFromApiService
            self?.updateView?()
        }
    }
 }
