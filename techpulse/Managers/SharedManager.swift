//
//  SharedNewsManager.swift
//  techpulse
//
//  Created by Luiz Felipe on 07/07/26.
//

import UIKit


class SharedManager {
    static func share(from viewController: UIViewController, url: String, message: String? = nil, barButtonItem: UIBarButtonItem? = nil) {
            guard let url = URL(string: url) else { return }
        
        var itemToShare: [Any] = [url]
        
        if let message = message {
            itemToShare.insert(message, at: 0)
        }
        
        let activityViewController = UIActivityViewController(activityItems: itemToShare, applicationActivities: nil)
        
        if let popoverController = activityViewController.popoverPresentationController {
            if let barButtonItem = barButtonItem {
                popoverController.barButtonItem = barButtonItem
            } else {
                popoverController.sourceView = viewController.view
                popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
                popoverController.permittedArrowDirections = []
            }
        }
        
        viewController.present(activityViewController, animated: true, completion: nil)
    }
}
