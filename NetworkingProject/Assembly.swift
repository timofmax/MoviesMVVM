//
//  Assembly.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 14.10.2021.
//

import UIKit

protocol AssemblyProtocol {
    func createMovieModule() -> UIViewController
//    func createMovieDetailModule(movieID: Int) -> UIViewController
}

final class Assembly: AssemblyProtocol {
    func createMovieModule() -> UIViewController {
        let movieAPIservice = MovieAPIService()
        let viewModel = MainScreenViewModel(movieAPIService: movieAPIservice)
        let view = MovieViewController(viewModel: viewModel)
        return view
    }

    func createMovieDetailModule(movieID: Int) -> UIViewController {
        let movieAPIservice = MovieAPIService()
        let viewModel = MovieDetailViewModel(movieID: movieID)
        let view = MovieDetailViewController(viewModel: viewModel)
        return view
    }
}
