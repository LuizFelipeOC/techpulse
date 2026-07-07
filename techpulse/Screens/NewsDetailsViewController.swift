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
    
    var body: String = ""
    
    var news: News?
    
    let bodytext = UITextView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewsData()

        configure()
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        configureBarNavigation()
        configureBody()
    }
    
    private func getNewsData() {
        showLoadingView()
        
        NetworkManager.shared.getTabnewsContent(for: userOwner, slug: slug, completed: {
            [weak self] result in
            
            
            guard let self = self else { return }
            
            switch(result) {
                case .success(let news):
                self.news = news
                let markdownString = news.body ?? ""
                
                DispatchQueue.global(qos: .userInitiated).async {
                    do {
                        let options = AttributedString.MarkdownParsingOptions(interpretedSyntax: .inlineOnlyPreservingWhitespace)
                        var attributedString = try AttributedString(markdown: markdownString, options: options)
                        
                        var container = AttributeContainer()
                        container.font = UIFont.systemFont(ofSize: 18, weight: .regular)
                        container.foregroundColor = UIColor.label
                        
                        attributedString.mergeAttributes(container, mergePolicy: .keepCurrent)
                        
                        let finalAttributedString = NSAttributedString(attributedString)
                        
                        DispatchQueue.main.async {
                            self.bodytext.attributedText = finalAttributedString
                        }
                        
                        
                    } catch {
                        print("Erro ao renderizar Markdown: \(error)")
                        DispatchQueue.main.async {
                            self.bodytext.text = markdownString
                            self.dimissLoadingView()
                        }
                    }
                }
                
                case .failure(let error):
                print(error)
                self.dimissLoadingView()
            }
        })
    }
    
    private func configureBarNavigation() {
        let appearance = UINavigationBarAppearance()
        
        let leftButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(dismissView))
        let rightButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(dismissView))

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
    
    func configureBody() {
        view.addSubview(bodytext)
        
        bodytext.isEditable = false
        bodytext.isScrollEnabled = true
        bodytext.textContainer.lineFragmentPadding = 0
        bodytext.translatesAutoresizingMaskIntoConstraints = false
            
        NSLayoutConstraint.activate([
            bodytext.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            bodytext.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            bodytext.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            bodytext.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    @objc private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
