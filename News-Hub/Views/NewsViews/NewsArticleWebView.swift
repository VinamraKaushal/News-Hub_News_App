//
//  NewsArticleWebView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct NewsArticleWebView: View {
    var newsUrl: String
    var body: some View {
        WebView(urlString: newsUrl)
            .padding(.top, 20)
    }
}
