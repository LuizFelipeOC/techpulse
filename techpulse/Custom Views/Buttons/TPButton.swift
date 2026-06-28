//
//  TPButton.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class TPButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTPButton()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(backgroundColor: UIColor, title: String) {
        super.init(frame: .zero)
        
        self.backgroundColor = backgroundColor
        self.setTitle(title, for: .normal)
    }
    
    private func configureTPButton() {
        layer.cornerRadius      = 20
        titleLabel?.textColor   = .white
        titleLabel?.font        = UIFont.preferredFont(forTextStyle: .headline)
        
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setBackgroundColor(backgroundColor: UIColor, title: String) {
          self.backgroundColor = backgroundColor
          setTitle(title, for: .normal)
      }
}
