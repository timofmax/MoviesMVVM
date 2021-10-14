//
//  MainCoordinator.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 14.10.2021.
//

import UIKit

final class MainCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    var onFinishFlow: VoidHandler?
    var assembly: AssemblyProtocol?
    var navController: UINavigationController?

    //MARK: - Initializers

    required init(assembly: AssemblyProtocol, navController: UINavigationController? = nil) {
        self.assembly = assembly
        self.navController = navController
        super.init(assembly: assembly, navController: navController)
    }

    // MARK: - MainCoordinator

    override func start() {
        showMainScreen()
    }

    // MARK: - Private methods

    private func showMainScreen() {
        guard let controller = assembly?.createMovieModule() as? MovieViewController else { fatalError() }

        controller.toDetailScreen = { [ weak self ] moveID in
            self?.showDetailViewController(moveID: moveID)
        }

        if navController == nil {
            let navController = UINavigationController(rootViewController: controller)
            self.navController = navController
            setAsRoot(navController)
        } else if let navController = navController {
            navController.pushViewController(controller, animated: true)
            setAsRoot(navController)
        }
    }

    private func showDetailViewController(moveID: Int) {
        guard let controller = assembly?.createMovieDetailModule(id: moveID) as? MovieDetailViewController
        else { fatalError() }
        navController?.pushViewController(controller, animated: true)
    }
}
