//
//  NewsViewModel.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation

struct NewsViewModel {
    let article: Article
    var author: String {
        return article.author ?? "Unknown"
    }
    var description: String {
        return article.description ?? ""
    }
    var title: String {
        return article.title ?? ""
    }
    var url: String {
        return article.url ?? ""
    }
    var urlToImage: String {
        return article.urlToImage ?? "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzfJAj2Z_XISd9a4wzcU_85njPmHCWDis49-0sJMAiZQ&s"
    }
}
