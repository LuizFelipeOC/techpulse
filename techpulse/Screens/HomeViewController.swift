//
//  HomeViewController.swift
//  techpulse
//
//  Created by Luiz Felipe on 27/06/26.
//

import UIKit

class HomeViewController: UIViewController {
    
    let page: Int = 1
    
    var newsList: [News] = []
    var collectionView: UICollectionView!


    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureHome()
        getRecentNews()
    }
    
    func getRecentNews() {
        NetworkManager.shared.fetchTabnewsRecentData(for: 10, completed: {
            [weak self] result in
            
            guard let self = self else { return }
            
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
    )}
    
    private func configureHome() {
        view.backgroundColor = .white
        
        configureBarNavigation()
        configureColletionView()
    }
    
    private func configureBarNavigation() {
        navigationItem.title = "Publicações recentes"
        
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
}

extension HomeViewController: UICollectionViewDataSource {
    
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

extension HomeViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) { }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }
}

extension HomeViewController: UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) { }
}
