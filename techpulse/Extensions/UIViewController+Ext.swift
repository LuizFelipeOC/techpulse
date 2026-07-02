//
//  UIViewController+Ext.swift
//  techpulse
//
//  Created by Luiz Felipe on 29/06/26.
//

import UIKit


fileprivate var containerView: UIView!

extension UIViewController {
    func showLoadingView() {
        containerView                       = UIView(frame: view.frame)
        containerView.backgroundColor       = .systemBackground
        containerView.alpha                 = 0
        
        UIView.animate(withDuration: 0.25, animations: {
            containerView.alpha = 0.8
        })
        
        let activtyIndicator = UIActivityIndicatorView(style: .large)
        activtyIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(activtyIndicator)
        view.addSubview(containerView)
        
        NSLayoutConstraint.activate([
            activtyIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activtyIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        activtyIndicator.startAnimating()
    }
    
    func dimissLoadingView() {
        DispatchQueue.main.async {
                guard containerView != nil else { return }
                
                UIView.animate(withDuration: 0.25, animations: {
                    containerView.alpha = 0
                }) { _ in
                    containerView.removeFromSuperview()
                    containerView = nil
                }
            }
    }
}
