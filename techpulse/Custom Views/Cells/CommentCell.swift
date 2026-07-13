import UIKit

class CommentCell: UITableViewCell {
    static let reuseID = "CommentCell"
    
    private let authorLabel = UILabel()
    private let dateLabel = UILabel()
    private let commentBodyLabel = UILabel()
    private let containerStack = UIStackView()
    private let headerStack = UIStackView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(comment: CommentsModel) {
        authorLabel.text = "@\(comment.ownerUsername)"
        dateLabel.text = comment.createdAt.convertToRelativeTime()
        
        let depthLevel = min(comment.depth, 4)
        let leftPadding: CGFloat = CGFloat(depthLevel) * 16.0
        
        containerStack.layoutMargins = UIEdgeInsets(top: 12, left: leftPadding, bottom: 12, right: 0)
        
        if comment.depth > 0 {
            contentView.backgroundColor = .systemGray6.withAlphaComponent(0.4)
        } else {
            contentView.backgroundColor = .clear
        }
        
        let bodyMarkdown = comment.body ?? ""
        bodyMarkdown.toMarkdownAttributedString(fontSize: 14) { [weak self] formattedText in
            DispatchQueue.main.async {
                self?.commentBodyLabel.attributedText = formattedText
            }
        }
    }
    
    private func configureUI() {
        selectionStyle = .none
        backgroundColor = .clear
        
        authorLabel.font = .systemFont(ofSize: 13, weight: .bold)
        authorLabel.textColor = .label
        authorLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        
        dateLabel.font = .systemFont(ofSize: 11, weight: .regular)
        dateLabel.textColor = .secondaryLabel
        
        commentBodyLabel.numberOfLines = 0
        commentBodyLabel.lineBreakMode = .byWordWrapping
        commentBodyLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        
        headerStack.axis = .horizontal
        headerStack.spacing = 6
        headerStack.alignment = .center
        headerStack.distribution = .fill
        
        headerStack.addArrangedSubview(authorLabel)
        headerStack.addArrangedSubview(dateLabel)
        
        containerStack.axis = .vertical
        containerStack.spacing = 6
        containerStack.isLayoutMarginsRelativeArrangement = true
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerStack.addArrangedSubview(headerStack)
        containerStack.addArrangedSubview(commentBodyLabel)
        
        contentView.addSubview(containerStack)
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
