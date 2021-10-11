//
//  ModuleBuilder.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 06.10.2021.
//

import Foundation
import UIKit

protocol AssemblyProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController
    func createDetailMovieModule(router: RouterProtocol, movieID: Int) -> UIViewController
}

final class AssemblyModelBuilder: AssemblyProtocol {
    func createMainModule(router: RouterProtocol) -> UIViewController {
        let movieApiService = MovieAPIService()
        let view = MenuViewController()
        let model: [Movie] = []
        let presenter = MoviePresenter(view: view, networkService: movieApiService, moviesList: model, router: router)
        view.presenter = presenter
        return view
    }

    func createDetailMovieModule(router: RouterProtocol, movieID: Int) -> UIViewController {
        let service = MovieAPIService()
        let view = DetailsViewController()
        let dataStorageService = DataStorageService()
        let presenter = DetailsPresenter(view: view, id: movieID, networkService: service, router: router, dataStorageService: dataStorageService)
        view.presenter = presenter
        return view
    }
}
