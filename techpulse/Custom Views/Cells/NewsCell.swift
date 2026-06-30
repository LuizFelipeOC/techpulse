//
//  NewsCell.swift
//  techpulse
//
//  Created by Luiz Felipe on 29/06/26.
//

import UIKit

class NewsCell: UICollectionViewCell {
    static let reuseID = "NewsCell"
    
    private let titleLabel = TPTitle(textAlignment: .left, fontSize: 18)
    private let usernameLabel = TPSecondaryLabel(textAlignment: .left, fontSize: 18)
    
    private let containerView = UIView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(News: News) {
        titleLabel.text = News.title
        usernameLabel.text = "@\(News.ownerUsername)"
    }
    
    
    private func configureCell() {
        configureContainer()
        configureTitleLabel()
        layoutConstraints()
    }
    
    private func configureContainer() {
        containerView.backgroundColor         = .secondarySystemBackground
        containerView.layer.cornerRadius      = 12
        containerView.layer.borderWidth       = 1
        containerView.layer.borderColor       = UIColor.separator.cgColor
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(containerView)
    }
    
    private func configureTitleLabel() {
        usernameLabel.font = .systemFont(ofSize: 13, weight: .medium)
        usernameLabel.textColor = .secondaryLabel
        
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(usernameLabel)
        self.containerView.addSubview(titleLabel)
    }
    
    private func layoutConstraints() {
            NSLayoutConstraint.activate([
                containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
                containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                usernameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
                usernameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                usernameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
                
                titleLabel.topAnchor.constraint(equalTo: usernameLabel.bottomAnchor, constant: 6),
                titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
                titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16)
            ])
        }
}
