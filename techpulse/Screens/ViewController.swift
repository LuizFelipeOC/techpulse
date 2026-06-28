//
//  ViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
    }
    
    
    private func configureView() {
        view.backgroundColor = .systemBackground
        
        helloWorld()
    }
    
    
    private func helloWorld() {
        let text = UILabel()
        
        text.text = "Hello World"
        text.textColor = .secondaryLabel
        text.font = UIFont.preferredFont(forTextStyle: .body)
        text.minimumScaleFactor = 0.5
        text.lineBreakMode = .byWordWrapping
        text.adjustsFontSizeToFitWidth = true
        text.translatesAutoresizingMaskIntoConstraints = false
    
        view.addSubview(text)
        
        NSLayoutConstraint.activate([
            text.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            text.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

