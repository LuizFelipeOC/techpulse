//
//  NewsDetailsViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 01/07/26.
//

import UIKit

class NewsDetailsViewController: UIViewController {
    
    var userOwner: String!
    var createdAt: String!
    var slug: String!
    
    var body: String                = ""
    
    var news: News?
    var comments: [CommentsModel]   = []
    
    let bodytext                    = UITextView()
    private let tableView           = UITableView(frame: .zero, style: .plain)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        getScreenData()
    }
    
    private func configure() {
        view.backgroundColor = .systemBackground
        
        configureBarNavigation()
        setupTableView()
    }
    
    private func getScreenData() {
        showLoadingView()
        
        let group = DispatchGroup()
        

        getNewsDetails(inside: group)
        getAllComments(inside: group)
        
        group.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            
            self.dimissLoadingView()
            self.tableView.reloadData()
            self.updateHeaderViewHeight()
        }
    }
    
    private func getNewsDetails(inside group: DispatchGroup) {
        group.enter()
        
        NetworkManager.shared.getTabnewsContent(for: userOwner, slug: slug) { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }
            
            switch result {
            case .success(let news):
                self.news = news
                let markdownString = news.body ?? ""
                
                markdownString.toMarkdownAttributedString { [weak self] formattedText in
                    self?.bodytext.attributedText = formattedText
                    self?.updateHeaderViewHeight()
                }
                
            case .failure(let error):
                print("Erro detalhes: \(error)")
            }
        }
    }
    
    private func getAllComments(inside group: DispatchGroup) {
        group.enter()
        
        NetworkManager.shared.getCommentNews(for: userOwner, slug: slug) { [weak self] result in
            defer { group.leave() }
            guard let self = self else { return }
            
            switch result {
            case .success(let nestedComments):
                self.comments = self.flattenComments(nestedComments, currentDepth: 0)
            case .failure(let error):
                print("Erro comentários: \(error)")
            }
        }
    }
    
    private func flattenComments(_ nestedComments: [CommentsModel], currentDepth: Int) -> [CommentsModel] {
        var flatList: [CommentsModel] = []
        
        for var comment in nestedComments {
            comment.depth = currentDepth
            flatList.append(comment)
            
            if !comment.children.isEmpty {
                let flatChildren = flattenComments(comment.children, currentDepth: currentDepth + 1)
                flatList.append(contentsOf: flatChildren)
            }
        }
        
        return flatList
    }
    
    private func configureBarNavigation() {
        let appearance = UINavigationBarAppearance()
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        let rightButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareController))

        leftButton.tintColor = .systemMint

        navigationItem.leftBarButtonItem = leftButton
        navigationItem.rightBarButtonItem = rightButton
        
        navigationItem.title = "@\(userOwner ?? "")"
        navigationItem.subtitle = createdAt.convertToRelativeTime()
        
        appearance.configureWithDefaultBackground()
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        appearance.subtitleTextAttributes = [.foregroundColor: UIColor.secondaryLabel, .font: UIFont.systemFont(ofSize: 14, weight: .medium)]
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        navigationController?.isNavigationBarHidden = false
        
        navigationItem.largeTitleDisplayMode = .always
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.isScrollEnabled = true
        tableView.alwaysBounceVertical = true
        
        tableView.separatorStyle = .singleLine
        tableView.register(CommentCell.self, forCellReuseIdentifier: CommentCell.reuseID)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 120
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        setupTableHeader()
    }
    
    private func setupTableHeader() {
        bodytext.isEditable = false
        bodytext.isScrollEnabled = false
        bodytext.textContainer.lineFragmentPadding = 0
        bodytext.font = .systemFont(ofSize: 18)
        
        let headerContainer = UIView()
        headerContainer.addSubview(bodytext)
        bodytext.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            bodytext.topAnchor.constraint(equalTo: headerContainer.topAnchor, constant: 16),
            bodytext.leadingAnchor.constraint(equalTo: headerContainer.leadingAnchor, constant: 16),
            bodytext.trailingAnchor.constraint(equalTo: headerContainer.trailingAnchor, constant: -16),
            bodytext.bottomAnchor.constraint(equalTo: headerContainer.bottomAnchor, constant: -16)
        ])
        
        headerContainer.frame = CGRect(x: 0, y: 0, width: view.bounds.width, height: 100)
        tableView.tableHeaderView = headerContainer
    }
    
    private func updateHeaderViewHeight() {
        guard let headerView = tableView.tableHeaderView else { return }
        
        let targetSize = CGSize(width: tableView.bounds.width, height: UIView.layoutFittingCompressedSize.height)
        let size = headerView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
        
        if headerView.frame.size.height != size.height {
            headerView.frame.size.height = size.height
            
            tableView.beginUpdates()
            tableView.tableHeaderView = headerView
            tableView.endUpdates()
        }
    }
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func shareController() {
        showLoadingView()
        
        let baseUrl  = "https://www.tabnews.com.br/"
        let text = "Confira essa publicação na pagina oficial da tabnews"
        
        guard let slug = slug else { return }
        guard let userOwner = userOwner else { return }
        
        let completeUrl = baseUrl + userOwner.lowercased() + "/" + slug

        DispatchQueue.main.async {
            self.dimissLoadingView()
            
            SharedManager.share(
                from: self,
                url: completeUrl,
                message: text,
                barButtonItem: self.navigationItem.rightBarButtonItem
            )
        }
    }
}

extension NewsDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CommentCell.reuseID, for: indexPath) as? CommentCell else {
            return UITableViewCell()
        }
        
        let comment = comments[indexPath.row]
        cell.set(comment: comment)
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return comments.isEmpty ? nil : "Comentários"
    }
}
