//
//  NewsListVM.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation

class NewsListVM: ObservableObject {
    @Published var news = [NewsViewModel]()
    @Published var imageData = [String: Data]()
    
    func load(category: String) {
        if (category != "") {
            NetworkManager.newsCategory = category
            getNewsWithCategory()
        } else {
            getNews()
        }
    }
    
    func load(domain: String) {
        NetworkManager.newsDomain = domain
        getNewsWithDomain()
    }
    
    private func getNews() {
        let networkManager = NetworkManager()
        networkManager.getNews { (newsArticles) in
            guard let news = newsArticles else { return }
            let newsVM = news.map(NewsViewModel.init)
            self.getImage(for: newsVM)
            DispatchQueue.main.async {
                self.news = newsVM
            }
        }
    }
    
    private func getNewsWithCategory() {
        let networkManager = NetworkManager()
        networkManager.getNewsWithCategory { (newsArticles) in
            guard let news = newsArticles else { return }
            let newsVM = news.map(NewsViewModel.init)
            self.getImage(for: newsVM)
            DispatchQueue.main.async {
                self.news = newsVM
            }
        }
    }
    
    private func getNewsWithDomain() {
        let networkManager = NetworkManager()
        networkManager.getNewsWithDomain { (newsArticles) in
            guard let news = newsArticles else { return }
            let newsVM = news.map(NewsViewModel.init)
            self.getImage(for: newsVM)
            DispatchQueue.main.async {
                self.news = newsVM
            }
        }
    }
    
    private func getImage(for news: [NewsViewModel]) {
        let nm = NetworkManager()
        news.forEach { n in
            guard !n.urlToImage.isEmpty else {
                return
            }
            nm.getImage(from: n.urlToImage) { (data) in
                guard let data = data else {
                    return
                }
                DispatchQueue.main.async {
                    self.imageData[n.urlToImage] = data
                }
            }
        }
    }
}
