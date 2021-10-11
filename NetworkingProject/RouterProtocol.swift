//
//  RouterProtocol.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 07.10.2021.
//

import UIKit

protocol RouterMain {
    var navigationController: UINavigationController? { get set }
    var assemblyBuilder: AssemblyProtocol? { get set }
}

protocol RouterProtocol {
    func initialViewController()
    func showMoviewDetail(movieId: Int)
}

/// Router
final class Router: RouterProtocol {
    var navigationController: UINavigationController?
    var assemblyBuilder: AssemblyProtocol?

    init(navigationController: UINavigationController, assemblyBuilder: AssemblyProtocol) {
        self.navigationController = navigationController
        self.assemblyBuilder = assemblyBuilder
    }

    func initialViewController() {
        if let navigationController = navigationController {
            guard let mainViewController = assemblyBuilder?.createMainModule(router: self) else { return }
            navigationController.viewControllers = [mainViewController]
        }
    }

    func showMoviewDetail(movieId: Int) {
        if let navigationController = navigationController {
            guard let detailViewController = assemblyBuilder?.createDetailMovieModule(router: self, movieID: movieId) else { return }
            navigationController.pushViewController(detailViewController, animated: true)
        }
    }
}
