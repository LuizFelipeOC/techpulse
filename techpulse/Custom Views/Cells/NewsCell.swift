//
//  NewsCell.swift
//  techpulse
//
//  Created by Luiz Felipe on 29/06/26.
//

import UIKit

class NewsCell: UICollectionViewCell {
    static let reuseID = "NewsCell"
    
    private let titleLabel          = TPTitle(textAlignment: .left, fontSize: 18)
    private let usernameLabel       = TPSecondaryLabel(textAlignment: .left, fontSize: 18)
    private let dateCreatedLabel    = TPSecondaryLabel(textAlignment: .left, fontSize: 18)
    private let countCommentLabel    = TPSecondaryLabel(textAlignment: .left, fontSize: 18)

    
    private let containerView       = UIView()
    private let headerStackView     = UIStackView()
    private let dateAndCommnetView  = UIStackView()
    private let countCommentView    = UIStackView()
    private let commentsIconView    = UIImageView()

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
        dateCreatedLabel.text = News.createdAt.convertToRelativeTime()
        countCommentLabel.text = String(News.childrenDeepCount)
    }
    
    private func configureCell() {
        configureContainer()
        
        configureTitleLabel()
        configureUsernameLabel()
        configureDateCreatedLabel()
        
        configureStackHeaderView()
        
        configureCountCommentview()
        configureCreateAndCommentView()

        layoutConstraints()
    }
    
    private func configureContainer() {
        containerView.backgroundColor         = .secondarySystemBackground
        containerView.layer.cornerRadius      = 12
        containerView.layer.borderWidth       = 1
        containerView.layer.borderColor       = UIColor.separator.cgColor
        
        containerView.translatesAutoresizingMaskIntoConstraints = false
        
        self.contentView.addSubview(containerView)
    }
    
    private func configureStackHeaderView() {
        headerStackView.axis = .horizontal
        headerStackView.distribution = .equalSpacing
        headerStackView.alignment = .center
        
        headerStackView.addArrangedSubview(usernameLabel)
        headerStackView.addArrangedSubview(dateAndCommnetView)
        
        headerStackView.translatesAutoresizingMaskIntoConstraints = false
        
        self.containerView.addSubview(headerStackView)
    }
    private func configureUsernameLabel() {
        usernameLabel.font = .systemFont(ofSize: 13, weight: .medium)
        usernameLabel.textColor = .secondaryLabel
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureTitleLabel() {
        titleLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        titleLabel.textColor = .label
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byTruncatingTail
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        self.containerView.addSubview(titleLabel)
    }
    
    private func configureDateCreatedLabel() {
        dateCreatedLabel.font = .systemFont(ofSize: 13, weight: .regular)
        dateCreatedLabel.textColor = .secondaryLabel
        dateCreatedLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCreateAndCommentView() {
        dateAndCommnetView.axis                                      = .horizontal
        dateAndCommnetView.spacing                                   = 12
        dateAndCommnetView.alignment                                 = .center
        
        dateAndCommnetView.addArrangedSubview(dateCreatedLabel)
        dateAndCommnetView.addArrangedSubview(countCommentView)
        
        dateAndCommnetView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func configureCountCommentview() {
        configureCommentView()
        
        commentsIconView.image                                      = UIImage(systemName: "message")
        commentsIconView.tintColor                                  = .secondaryLabel
        commentsIconView.tintColor.withAlphaComponent(0.5)
        commentsIconView.contentMode                                = .scaleAspectFit
        commentsIconView.translatesAutoresizingMaskIntoConstraints  = false
        
        
        countCommentView.spacing                                    = 4
        countCommentView.addArrangedSubview(commentsIconView)
        countCommentView.addArrangedSubview(countCommentLabel)
        countCommentView.translatesAutoresizingMaskIntoConstraints  = false
    }
    
    private func configureCommentView() {
        countCommentLabel.font                                      = .systemFont(ofSize: 13, weight: .regular)
        countCommentLabel.textColor                                 = .secondaryLabel
        countCommentView.translatesAutoresizingMaskIntoConstraints  = false
    }
    
    private func layoutConstraints() {
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            headerStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 14),
            headerStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            headerStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            
            titleLabel.topAnchor.constraint(equalTo: headerStackView.bottomAnchor, constant: 6),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(lessThanOrEqualTo: containerView.bottomAnchor, constant: -14),
            
            commentsIconView.widthAnchor.constraint(equalToConstant: 16),
            commentsIconView.heightAnchor.constraint(equalToConstant: 16)
        ])
    }
}
