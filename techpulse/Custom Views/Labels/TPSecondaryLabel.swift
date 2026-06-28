//
//  TPSecondaryLabel.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class TPSecondaryLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureTPTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    init(textAlignment: NSTextAlignment, fontSize: CGFloat) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textAlignment                             = textAlignment
        self.font                                      = .systemFont(ofSize: fontSize, weight: .medium)
    }
    
    
    private func configureTPTitleLabel() {
        textColor                   = .secondaryLabel
        adjustsFontSizeToFitWidth   = true
        minimumScaleFactor          = 0.5
        lineBreakMode               = .byTruncatingTail
    }
}
