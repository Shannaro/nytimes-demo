//
//  DataManager.swift
//  nytimes
//
//  Created by Shantanu Khanwalkar on 07/07/18.
//  Copyright © 2018 Shantanu Khanwalkar. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    
    case unknown
    case failedRequest
    case invalidResponse
    
}

final class DataManager {
    
    typealias ArticlesDataCompletion = (ArticlesData?, DataManagerError?) -> ()
    
    // MARK: - Properties
    
    private let baseURLString: String
    
    // MARK: - Initialization
    
    init(baseURLString: String) {
        self.baseURLString = baseURLString
    }
    
    // MARK: - Requesting Data
    
    func articlesIn(section: String, period: Int, completion: @escaping ArticlesDataCompletion) {
        // Create URL
        var components = URLComponents(string: "\(baseURLString)\(section)/\(period).json")!
        components.query = API.APIKey
        
        // Create Data Task
        URLSession.shared.dataTask(with: components.url!) { (data, response, error) in
            DispatchQueue.main.async {
                self.didFetchArticlesData(data: data, response: response, error: error, completion: completion)
            }
            }.resume()
    }
    
    // MARK: - Helper Methods
    
    private func didFetchArticlesData(data: Data?, response: URLResponse?, error: Error?, completion: ArticlesDataCompletion) {
        if let _ = error {
            completion(nil, .failedRequest)
            
        } else if let data = data, let response = response as? HTTPURLResponse {
            
            if response.statusCode == 200 {
                do {
                    
                    // Decode JSON
                    let decoder = JSONDecoder()
                    let articlesData = try decoder.decode(ArticlesData.self, from: data)
                    
                    // Invoke Completion Handler
                    completion(articlesData, nil)
                    
                } catch {
                    // Invoke Completion Handler
                    completion(nil, .invalidResponse)
                }
                
            } else {
                completion(nil, .failedRequest)
            }
            
        } else {
            completion(nil, .unknown)
        }
    }
    
}
