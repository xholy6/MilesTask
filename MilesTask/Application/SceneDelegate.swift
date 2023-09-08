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
        let isLogouted = UserDefaults.standard.bool(forKey: "isLogouted")
        let controller = !isLogouted ? ProfileViewController() : LoginViewController()
        let nvc = UINavigationController(rootViewController: controller)
        return nvc
    }
}
