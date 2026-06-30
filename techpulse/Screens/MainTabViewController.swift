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
            
            let homeNavigation = UINavigationController(rootViewController: homeVC)
            
            homeNavigation.tabBarItem = UITabBarItem(title: "Início", image: UIImage(systemName: "house"), tag: 0)
            
            setViewControllers([homeNavigation], animated: false)
        }

}
