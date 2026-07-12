//
//  SettingTableViewCell.swift
//  techpulse
//
//  Created by Luiz Felipe on 12/07/26.
//

import UIKit

class SettingTableViewCell: UITableViewCell {
    static let reuseID: String = "SettingTableViewCell"
    
    let iconContainer = UIView()
    let iconView      = UIImageView()
    let label         = TPSecondaryLabel(textAlignment: .left, fontSize: 16)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
                
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    func set(options: SettingOption) {
        label.text = options.title
        iconView.image = options.icon
        iconContainer.backgroundColor = options.iconBackgroundColor
    }
    
    private func configure() {
        configureIconContainer()
        configureIconView()
        configureLabel()
        
        setupConstraints()
    }
    
    private func configureIconContainer() {
        iconContainer.layer.cornerRadius                        = 8
        iconContainer.clipsToBounds                             = true
        iconContainer.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(iconContainer)
    }
    
    private func configureIconView() {
        iconView.tintColor                                 = .white
        iconView.contentMode                               =  .scaleAspectFit
        iconView.translatesAutoresizingMaskIntoConstraints = false
        
        iconContainer.addSubview(iconView)
    }
    
    private func configureLabel() {
        contentView.addSubview(label)
    }
    
    private func setupConstraints() {
            NSLayoutConstraint.activate([
                iconContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                iconContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
                iconContainer.widthAnchor.constraint(equalToConstant: 32),
                iconContainer.heightAnchor.constraint(equalToConstant: 32),
                
                iconView.centerXAnchor.constraint(equalTo: iconContainer.centerXAnchor),
                iconView.centerYAnchor.constraint(equalTo: iconContainer.centerYAnchor),
                iconView.widthAnchor.constraint(equalToConstant: 22),
                iconView.heightAnchor.constraint(equalToConstant: 22),
                
                label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
                label.leadingAnchor.constraint(equalTo: iconContainer.trailingAnchor, constant: 12),
                label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16)
            ])
        }
}
