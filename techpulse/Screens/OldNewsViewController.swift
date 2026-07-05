//
//  OldNewsViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 01/07/26.
//

import UIKit

class OldNewsViewController: UIViewController {
    
    var newsList: [News] = []
    var collectionView: UICollectionView!
    
    var page: Int = 1
    var hasLoadMore: Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        getOldNews(for: page)
    }
    
    private func getOldNews(for page: Int) {
        showLoadingView()
        
        NetworkManager.shared.fetchTabnewsData(for: page, strategy: Strategy.old, completed: {
            [weak self] result in
            
            guard let self = self else { return }
            
            self.dimissLoadingView()
                        
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
        })
    }
    
    private func configure() {
        view.backgroundColor = .white
        
        configureBarNavigation()
        configureColletionView()
    }
    
    private func configureBarNavigation() {
        view.backgroundColor = .white
        
        navigationItem.title = "Publicações Antigas"
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
    
    private func configureColletionView() {
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout:     UIHelper.createSingleColumnFlowLayout(in: view))

        view.addSubview(collectionView)
        
        collectionView.delegate = self
        collectionView.dataSource = self
                
        collectionView.backgroundColor = .systemBackground
        collectionView.register(NewsCell.self, forCellWithReuseIdentifier: NewsCell.reuseID)
    }
}

extension OldNewsViewController: UICollectionViewDataSource {
    
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

extension OldNewsViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.height
        
        if offsetY > contentHeight - height {
            guard hasLoadMore else { return }
            
            page += 1
            getOldNews(for: page)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray     = newsList
        let newsItem        = activeArray[indexPath.item]
        
        let vc              = NewsDetailsViewController()
        vc.title            = newsItem.title
        vc.userOwner        = newsItem.ownerUsername
        vc.slug             = newsItem.slug
        vc.createdAt        = newsItem.createdAt
        
        let navigationController    = UINavigationController(rootViewController: vc)
        
        present(navigationController, animated: true)
    }
}
