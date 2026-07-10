//
//  NetworkManager.swift
//  techpulse
//
//  Created by Luiz Felipe on 28/06/26.
//

import UIKit

enum Strategy: String, Codable {
    case new
    case relevant
    case old
}

class NetworkManager {
    static let shared = NetworkManager()
    
    let url = "https://www.tabnews.com.br/api/v1"
    
    func fetchTabnewsData(for page: Int, strategy: Strategy , completed: @escaping (Result<[News], TPError>) -> Void) {
        let endpoint = url + "/contents?&page=\(page)&per_page=10&strategy=\(strategy.rawValue)"
        
        guard let url = URL(string: endpoint) else {
            completed(.failure(TPError.invalidURL))
            
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) {
            data, response, error in
            
            if let _ = error {
                completed(.failure(TPError.invalidResponse))
                return
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let _ = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let news: [News] = try decoder.decode([News].self, from: data!)
                
                completed(.success(news))
            } catch {
                print("Erro de decodificação: \(error)")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
    
    
    func getTabnewsContent(for username: String, slug: String, completed: @escaping (Result<News, TPError>) -> Void){
        let endpoint = url + "/contents/\(username)/\(slug)"
            
        guard let  url = URL(string: endpoint) else {
            completed(.failure(.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                completed(.failure(.invalidResponse))
                return
                
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completed(.failure(.invalidResponse))
                return
            }
            
            guard let _ = data else {
                completed(.failure(.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let news: News = try decoder.decode(News.self, from: data!)
                completed(.success(news))

            } catch {
                print("Erro de decodificação: \(error)")
                completed(.failure(.invalidData))
            }
        }
        task.resume()
    }
    
    
    func getCommentNews(for userId: String, slug: String, completed: @escaping (Result<[CommentsModel], TPError>) -> Void){
        let endpoint = url + "/contents/\(userId)/\(slug)/childreen"
        
        guard let url = URL(string: endpoint) else { return }
        
        let task =  URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let _ = error {
                return  completed(.failure(.invalidResponse))
                
            }
            
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
               return completed(.failure(.invalidResponse))
            }
            
            guard let _ = data else {
              return  completed(.failure(.invalidData))
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                
                let comments = try decoder.decode(CommentsModel.self, from: data!)
                return completed(.success([comments]))
            } catch {
                print("Erro de decodificação: \(error)")
                completed(.failure(.invalidData))
            }
        }
        
        task.resume()
    }
}
