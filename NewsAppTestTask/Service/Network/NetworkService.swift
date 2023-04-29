//
//  NetworkService.swift
//  NewsAppTestTask
//
//  Created by Артем Орлов on 27.04.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case invalidData
}

final class NetworkService {
    
    private let apiKey = "ae7ec2d4e3664bf3bd4d73ebca4f516f"
    
    func fetchArticles(page: Int, completion: @escaping (Result<NewsResponse, Error>) -> Void) {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines"
        components.queryItems = [
            "country": "us",
            "page": "\(page)",
            "apiKey": apiKey
        ].map { URLQueryItem(name: $0.key, value: $0.value) }
        
        guard let url = components.url else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.invalidData))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let response = try decoder.decode(NewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            } catch {
                completion(.failure(error))
            }
        }
        task.resume()
    }
}
