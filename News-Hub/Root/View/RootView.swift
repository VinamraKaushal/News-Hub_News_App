//
//  ContentView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 26/03/24.
//


import SwiftUI

struct RootView: View {
    @AppStorage("showOnboarding") var showOnboarding: Bool = true
    @StateObject var viewModel = RootViewModel()
    
    var body: some View {
        NavigationStack {
            if showOnboarding {
                OnboardingView(showOnboarding: $showOnboarding)
            } else {
                if viewModel.userSession != nil {
                    MainView()
                } else {
                    LoginView()
                }
            }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
