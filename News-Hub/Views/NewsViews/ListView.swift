//
//  ListView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct ListView: View {
    let newsCollection: [NewsViewModel]
    let imageData: [String: Data]
    var body: some View {
        List(self.newsCollection, id: \.url) { news in
            if let imageData = self.imageData[news.urlToImage], let uiImage = UIImage(data: imageData) {
                NewsCell(news: news, image: Image(uiImage: uiImage))
            } else {
                NewsCell(news: news, image: Image(systemName: "doc.append"))
            }
        }
        .scrollContentBackground(.hidden)
    }
}

