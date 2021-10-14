//  BaseCoordinator.swift
//  NetworkingProject
//
//  Created by Timofey Privalov on 14.10.2021.
//

import UIKit
/// BaseCoordinator
class BaseCoordinator {
    // MARK: - Private Properties
    private var childCoordinators: [BaseCoordinator] = []

    // MARK: - Lifecycle

    required init(assembly: AssemblyProtocol, navController: UINavigationController? = nil) {}

    // MARK: - Public Methods

    func start() {}

    func addDependency(_ coordinator: BaseCoordinator) {
        for element in childCoordinators where element === coordinator {
            return
        }
        childCoordinators.append(coordinator)
    }

    func removeDependency(_ coordinator: BaseCoordinator?) {
        guard !childCoordinators.isEmpty,
              let coordinator = coordinator
        else { return }
        for (index, element) in childCoordinators.reversed().enumerated() where element === coordinator {
            childCoordinators.remove(at: index)
            break
        }
    }

    func setAsRoot(_ controller: UIViewController) {
        let keyWindow = UIApplication
            .shared
            .connectedScenes
            .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
            .first { $0.isKeyWindow }

        keyWindow?.rootViewController = controller
    }
}
