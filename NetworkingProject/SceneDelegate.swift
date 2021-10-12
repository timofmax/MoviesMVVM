// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        let viewControler = MainViewController()
        let navController = UINavigationController(rootViewController: viewControler)
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
    }
}
