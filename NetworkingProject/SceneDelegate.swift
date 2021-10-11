// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        let viewControler = MenuViewController()
        let navController = UINavigationController(rootViewController: viewControler)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
