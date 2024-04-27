//
//  ChannelNewsList.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 17/04/24.
//

import SwiftUI

struct ChannelNewsList: View {
    var domain: String
    var title: String
    @ObservedObject private var newsListVM = NewsListVM()
    init(domain: String, title: String) {
        self.domain = domain
        self.title = title
        newsListVM.load(domain: domain)
    }
    var body: some View {
        VStack {
            ListView(newsCollection: self.newsListVM.news, imageData: self.newsListVM.imageData)
        }
        .navigationTitle(title)
    }
}

#Preview {
    ChannelNewsList(domain: "", title: "")
}
