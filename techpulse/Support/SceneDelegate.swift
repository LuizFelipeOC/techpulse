//
//  SceneDelegate.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let window = UIWindow(windowScene: windowScene)
        
        if OnboardingManager.hasSeenOnboarding {
            let navigation = UINavigationController(rootViewController: MainTabViewController())
            window.rootViewController = navigation
        } else {
            let rootVC = OnboardingViewController()
            let navigation = UINavigationController(rootViewController: rootVC)
            
            window.rootViewController = navigation
        }
        
        self.window = window
        window.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}

