//
//  PostData.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation

struct Results: Codable {
    let articles: [Article]
}

struct Article: Codable {
    
    let author: String?
    let title: String?
    let description: String?
    let url: String?
    let urlToImage: String?
    
    enum CodingKeys: String, CodingKey {
        case author, title, description, url, urlToImage
    }
}
