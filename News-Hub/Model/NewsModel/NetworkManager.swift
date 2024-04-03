//
//  NetworkManager.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation


class NetworkManager: ObservableObject {
    
    private let baseUrlString = "https://newsapi.org/v2/"
    private let inTopHeadlines = "top-headlines?country=in"
    static var newsCategory = ""
    
    func getNews(completion: @escaping (([Article]?) -> Void)) {
        let urlString = "\(baseUrlString)\(inTopHeadlines)&apiKey=\(API.key)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let newsRes = try? JSONDecoder().decode(Results.self, from: data)
            newsRes == nil ? completion(nil) : completion(newsRes!.articles)
        }.resume()
    }
    
    func getNewsWithCategory(completion: @escaping (([Article]?) -> Void)) {
        let urlString = "\(baseUrlString)\(inTopHeadlines)&category=\(NetworkManager.newsCategory)&apiKey=\(API.key)"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                completion(nil)
                return
            }
            let newsRes = try? JSONDecoder().decode(Results.self, from: data)
            newsRes == nil ? completion(nil) : completion(newsRes!.articles)
        }.resume()
    }
    
    func getImage(from urlString: String, completion: @escaping (Data?) -> Void) {
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            completion(data)
        }.resume()
    }

}
