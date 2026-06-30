//
//  NetworkManager.swift
//  techpulse
//
//  Created by Luiz Felipe on 28/06/26.
//

import UIKit

class NetworkManager {
    static let shared = NetworkManager()
    
    let url = "https://www.tabnews.com.br/api/v1"
    
    func fetchTabnewsRecentData(for page: Int , completed: @escaping (Result<[News], TPError>) -> Void) {
        let endpoint = url + "/contents?&page=\(page)&per_page=10&strategy=new"
        
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
}
