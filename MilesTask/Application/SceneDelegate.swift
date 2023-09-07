//
//  SceneDelegate.swift
//  MilesTask
//
//  Created by D on 07.09.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        window?.rootViewController =  decideToCreateVC()
        window?.makeKeyAndVisible()
    }

    private func decideToCreateVC() -> UIViewController {
        let isLaunchExists = UserDefaults.standard.bool(forKey: "isFirstAppLaunch")
        let controller = isLaunchExists ? ProfileViewController() : LoginViewController()
        return controller
    }
}

