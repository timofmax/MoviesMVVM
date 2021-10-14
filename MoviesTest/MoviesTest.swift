//
//  MoviesTest.swift
//  MoviesTest
//
//  Created by Timofey Privalov on 14.10.2021.
//

@testable import NetworkingProject
import UIKit
import XCTest

final class MockNavigationController: UINavigationController {
    var presentedVC: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        presentedVC = viewController
        super.pushViewController(viewController, animated: animated)
    }

}


class MoviesTest: XCTestCase {

    var coordinator: ApplicationCoordinator!
    var navController: MockNavigationController!
    var assembly: AssemblyProtocol!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        navController = MockNavigationController()
        assembly = Assembly()
        coordinator = ApplicationCoordinator(assembly: assembly, navController: navController)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        navController = nil
        assembly = nil
        assembly = nil
    }

    func testMainViewControllerScreen() throws {
        coordinator.start()
        let movieVC = navController.presentedVC
        XCTAssertTrue(movieVC is MovieViewController)
    }

    func testDetailViewControllerScreen() {
        coordinator.start()
        guard let movieViewController = navController.presentedVC as? MovieViewController else { return }
        movieViewController.toDetailScreen?(0)
        let movieDetailViewController = navController.presentedVC
        XCTAssertTrue(movieDetailViewController is MovieDetailViewController)
    }

}
