//
//  SettingsViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 10/07/26.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        setupNavigationBar()
    }
    
    
    private func setupNavigationBar() {
        navigationItem.title = "Configurações"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.isNavigationBarHidden = false
    }
}
