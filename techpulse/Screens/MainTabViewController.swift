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
            
            let homeController = UINavigationController(rootViewController: homeVC)
            let relevantNewsNavController = UINavigationController(rootViewController: relevantNewsVc)
            
            homeController.tabBarItem = UITabBarItem(title: "Recentes", image: UIImage(systemName: "house"), tag: 0)
            relevantNewsNavController.tabBarItem = UITabBarItem(title: "Relevantes", image: UIImage(systemName: "star"), tag: 1)
            
            setViewControllers([homeController, relevantNewsNavController], animated: true)
    }
}
