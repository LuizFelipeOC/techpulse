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
        
        tabBar.tintColor = .systemMint
    }
    
    private func setupTabs() {
            let homeVC = HomeViewController()
            let relevantNewsVc = RelevantsNewsViewController()
            let oldNewsVC = OldNewsViewController()
            
            let homeController = UINavigationController(rootViewController: homeVC)
            let relevantNewsNavController = UINavigationController(rootViewController: relevantNewsVc)
            let oldNewsNavController = UINavigationController(rootViewController: oldNewsVC)
            
            homeController.tabBarItem = UITabBarItem(title: "Recentes", image: UIImage(systemName: "house"), tag: 0)
            relevantNewsNavController.tabBarItem = UITabBarItem(title: "Relevantes", image: UIImage(systemName: "star"), tag: 1)
            oldNewsVC.tabBarItem = UITabBarItem(title: "Antigos", image: UIImage(systemName: "book"), tag: 2)
            
            setViewControllers([homeController, relevantNewsNavController, oldNewsNavController], animated: true)
    }
}
