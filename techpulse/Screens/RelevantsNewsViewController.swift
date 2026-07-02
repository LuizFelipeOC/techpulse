//
//  RelevantsNewsViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 30/06/26.
//

import UIKit

class RelevantsNewsViewController: UIViewController {
    
    var newsList: [News] = []
    
    var collectionView: UICollectionView!
    
    var hasLoadMore: Bool = true
    var page: Int = 1
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        fetchRelevantNews(for: page)
    }
    
    private func configure() {
        configureBarNavigation()
        configureColletionView()
    }
    
    private func configureBarNavigation() {
        view.backgroundColor = .white
        
        navigationItem.title = "Publicações Relevantes"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        
        appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.label]
        appearance.titleTextAttributes = [.foregroundColor: UIColor.label]
        
        navigationController?.navigationBar.standardAppearance = appearance
        navigationController?.navigationBar.compactAppearance = appearance
        navigationController?.navigationBar.scrollEdgeAppearance = appearance
        
        navigationController?.isNavigationBarHidden = false
    }

    func configureColletionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:     UIHelper.createSingleColumnFlowLayout(in: view))

        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
                
        collectionView.backgroundColor = .systemBackground
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
    }
    
    private func fetchRelevantNews(for page: Int){
        NetworkManager.shared.fetchTabnewsData(for: page, strategy: Strategy.relevant, completed: {
            [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success(let news):
                    self.newsList.append(contentsOf: news)
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                case .failure(let error):
                    return print(error)
                }
            }
        }
    )}
}

extension RelevantsNewsViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return newsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCell.reuseID, for: indexPath) as? NewsCell else {
            return UICollectionViewCell()
        }
                
        let newsItem = newsList[indexPath.item]
        cell.set(News: newsItem)
        
        cell.backgroundColor = .systemGray6
        cell.layer.cornerRadius = 8
        
        return cell
    }
}

extension RelevantsNewsViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            guard hasLoadMore else { return }
            
            page += 1
            fetchRelevantNews(for: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray             = newsList
        let news                    = activeArray[indexPath.item]
        
        let newsDetailsVC           = NewsDetailsViewController()
        
        newsDetailsVC.userOwner     = news.ownerUsername
        newsDetailsVC.createdAt     = news.createdAt
        newsDetailsVC.slug          = news.slug
        
        let navigationController    = UINavigationController(rootViewController: newsDetailsVC)
        
        present(navigationController, animated: true)

    }
}
