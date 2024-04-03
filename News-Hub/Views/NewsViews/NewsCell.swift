//
//  NewsCell.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct NewsCell: View {
    let news: NewsViewModel
    let image: Image
    @State private var isPresented: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            image
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: UIScreen.main.bounds.width - 70, height: 200, alignment: .center)
                .clipped()
                .cornerRadius(20)
                .shadow(color: Color(.systemRed), radius: 5)
            Text(news.author)
                .font(.subheadline)
                .padding(10)
                .foregroundStyle(.white)
                .background(Color(.systemRed))
                .cornerRadius(20)
            Text(news.title)
                .font(.subheadline)
            Text(news.description)
                .font(.caption)
        }.sheet(isPresented: $isPresented) {
            NewsArticleWebView(newsUrl: self.news.url)
        }.onTapGesture {
            self.isPresented.toggle()
        }
    }
}
