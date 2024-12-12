//
//  SceneDelegate.swift
//  QuizApp
//
//  Created by Ana on 11/12/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        
        let viewModel = StartPageViewModel()
        let viewController = StartPageViewController(viewModel: viewModel)
        window.rootViewController = UINavigationController(rootViewController: viewController)
        self.window = window
        self.window?.makeKeyAndVisible()
    }
}
