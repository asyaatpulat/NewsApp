//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Asya Atpulat on 10.09.2023.
//

import Foundation
enum Path {
    case category(category: String, country: String)
    case country(country: String)
    case search(searchText: String)
    
    var baseURL: String {
        return "https://newsapi.org/v2/top-headlines"
    }
    var everytingURL: String {
         return "https://newsapi.org/v2/everything"
    }
    
    var apiKey: String {
        return "69ac707291b548c985685f955999a51e"
    }
    
    var path: URL {
        switch self {
        case .category(let category, let country):
            let urlString = "\(baseURL)?country=\(country)&category=\(category)&apiKey=\(apiKey)"
            return URL(string: urlString)!
        case .country(let country):
            let urlString = "\(baseURL)?country=\(country)&apiKey=\(apiKey)"
            return URL(string: urlString)!
        case .search(let searchText):
               guard let encodedSearchText = searchText.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {
                   fatalError("Failed to encode searchText")
               }
               let urlString = "\(everytingURL)?q=\(encodedSearchText)&apiKey=\(apiKey)"
               if let url = URL(string: urlString) {
                   return url
               } else {
                   fatalError("Failed to create URL")
               }
        }
    }
}


struct Resource<T:Decodable> {
    var url: Path
}

final class NetworkManager {
    
    static let shared = NetworkManager()
        
    func fetchNews<T: Decodable>(resource: Resource<T>, completion: @escaping (Result<T, Error>) -> ()) {
        URLSession.shared.dataTask(with: resource.url.path) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                guard let data = data else {
                    completion(.failure(NSError(domain: "Data Error", code: 0)))
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .formatted(.iso8601Full) // Set date decoding strategy
                    let decodedData = try decoder.decode(T.self, from: data)
                    completion(.success(decodedData))
                } catch {
                    completion(.failure(NSError(domain: "Decode Error", code: 0)))
                }
            }.resume()
    }
}

