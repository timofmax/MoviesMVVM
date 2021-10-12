// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo _: UISceneSession, options _: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navController = UINavigationController()
        let viewControler = MainViewController()
        let mainScreenViewModel = MainScreenViewModel()
        viewControler.mainViewModel = mainScreenViewModel
        navController.viewControllers = [viewControler]
        navController.navigationBar.isHidden = false

        window.rootViewController = navController
        window.makeKeyAndVisible()
    }
}
