//  Created by Timofey Privalov on 14.10.2021.
//

import UIKit
/// ApplicationCoordinator
final class ApplicationCoordinator: BaseCoordinator {
    // MARK: - Public Properties

    private var assembly: AssemblyProtocol?
    private var navController: UINavigationController?

    //MARK: - Initializers

    required init(assembly: AssemblyProtocol, navController: UINavigationController? = nil) {
        self.assembly = assembly
        self.navController = navController
        super.init(assembly: assembly, navController: navController)
    }

    // MARK: - ApplicationCoordinator
    override func start() {
        toMain()
    }

    //MARK: - Private methods

    private func toMain() {
        guard let assembly = assembly else { fatalError() }

        let coordinator = MainCoordinator(assembly: assembly, navController: navController)

        coordinator.onFinishFlow = { [weak self] in
            self?.removeDependency(coordinator)
            self?.start()
        }

        addDependency(coordinator)
        coordinator.start()
    }

}
