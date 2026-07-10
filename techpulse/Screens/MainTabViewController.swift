//
//  MainTabViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class MainTabViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTabs()
    }
    
    private func setupTabs() {
            tabBar.tintColor = .systemMint

        
            let homeVC                          = HomeViewController()
            let relevantNewsVc                  = RelevantsNewsViewController()
            let oldNewsVC                       = OldNewsViewController()
            let settingsVc                      = SettingsViewController()
            
            let homeController                  = UINavigationController(rootViewController: homeVC)
            let relevantNewsNavController       = UINavigationController(rootViewController: relevantNewsVc)
            let oldNewsNavController            = UINavigationController(rootViewController: oldNewsVC)
            let settingsNavController           = UINavigationController(rootViewController: settingsVc)
            
            homeController.tabBarItem            = UITabBarItem(title: "Recentes", image: UIImage(systemName: "house"), tag: 0)
            relevantNewsNavController.tabBarItem = UITabBarItem(title: "Relevantes", image: UIImage(systemName: "star"), tag: 1)
            oldNewsVC.tabBarItem                 = UITabBarItem(title: "Antigos", image: UIImage(systemName: "book"), tag: 2)
            settingsVc.tabBarItem                = UITabBarItem(title: "Configurações", image: UIImage(systemName: "gear"), tag: 3)
            
            setViewControllers([homeController, relevantNewsNavController, oldNewsNavController, settingsNavController], animated: true)
    }
}
