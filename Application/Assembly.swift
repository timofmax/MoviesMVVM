//
//  Assembly.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 14.10.2021.
//

import UIKit

protocol AssemblyProtocol {
    func createMovieModule() -> UIViewController
    func createMovieDetailModule(id: Int) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    func createMovieModule() -> UIViewController {
        let movieAPIservice = MovieAPIService()
        let repository = RealmRepository<MovieRealm>()
        let viewModel = MainScreenViewModel(movieAPIService: movieAPIservice, repository: repository)
        let view = MovieViewController(viewModel: viewModel)
        return view
    }

    func createMovieDetailModule(id: Int) -> UIViewController {
        let movieAPIservice = MovieAPIService()
        let repository = RealmRepository<MovieDetailRealm>()
        let viewModel = MovieDetailViewModel(movieAPIService: movieAPIservice, repository: repository)
        let view = MovieDetailViewController(viewModel: viewModel, id: id)
        return view
    }
}
