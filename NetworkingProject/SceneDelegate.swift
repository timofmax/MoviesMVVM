// SceneDelegate.swift
// Copyright © RoadMap. All rights reserved.

import UIKit

// SceneDelegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo _: UISceneSession,
        options _: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        self.window = window

        let navController = UINavigationController()
        let assemblyBuilder = AssemblyModelBuilder()
        let router = Router(navigationController: navController, assemblyBuilder: assemblyBuilder)

        router.initialViewController()

        self.window?.rootViewController = navController
        self.window?.backgroundColor = .white
        self.window?.makeKeyAndVisible()
    }
}
