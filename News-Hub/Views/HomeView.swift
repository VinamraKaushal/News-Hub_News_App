//
//  HomeView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct HomeView: View {
    
    @ObservedObject private var newsListVM = NewsListVM()
    private let categories = ["All", "Business", "Entertainment", "Health", "Science", "Sports", "Technology"]
    @State private var selectedIndex: Int = 0
    init() {
        newsListVM.load(category: "")
    }
    
    var body: some View {
        VStack {
            HeaderView()
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 0) {
                    ForEach(0 ..< categories.count, id: \.self) { i in
                        CategoryView(isActive: i == selectedIndex, text: categories[i])
                            .onTapGesture {
                                selectedIndex = i
                                if(selectedIndex == 0) {
                                    newsListVM.load(category: "")
                                } else {
                                    newsListVM.load(category: categories[selectedIndex].lowercased())
                                }
                            }
                    }
                }
            }.padding(.leading, 16)
            ListView(newsCollection: self.newsListVM.news, imageData: self.newsListVM.imageData)
        }
    }
}

#Preview {
    HomeView()
}

struct CategoryView: View {
    let isActive: Bool
    let text: String
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(text)
                .font(.subheadline)
                .frame(width: 120, height: 35)
                .foregroundStyle(.white)
                .background(isActive ? Color(.systemGray) : Color(.systemRed))
                .cornerRadius(20)
        }
        .padding(.trailing)
    }
}
