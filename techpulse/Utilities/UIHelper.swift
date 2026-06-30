//
//  UIHelper.swift
//  techpulse
//
//  Created by Luiz Felipe on 29/06/26.
//

import UIKit

enum UIHelper {
    
    static func createThreeColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
        let width                   = view.bounds.width
        let padding: CGFloat        = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth          = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth               = availableWidth / 3
        
        let flowLayout              = UICollectionViewFlowLayout()
        flowLayout.sectionInset     = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize         = CGSize(width: itemWidth, height: itemWidth + 40)        
        return flowLayout
    }
    
    static func createSingleColumnFlowLayout(in view: UIView) -> UICollectionViewFlowLayout {
            let width = view.bounds.width
            let padding: CGFloat = 16
            let availableWidth = width - (padding * 2)
            
            let flowLayout = UICollectionViewFlowLayout()
            flowLayout.sectionInset = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
            flowLayout.minimumLineSpacing = 12 
            
            flowLayout.itemSize = CGSize(width: availableWidth, height: 90)
            
            return flowLayout
        }
}
