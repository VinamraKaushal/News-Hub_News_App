//
//  MainView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            HomeView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
            ChannelView()
                .tabItem {
                    Label("Channels", systemImage: "globe")
                }
            ProfileView()
                .tabItem {
                    Label("Profile", systemImage: "person.fill")
                }
        }
        .toolbarBackground(.visible, for: .tabBar)
    }
}

#Preview {
    MainView()
}
