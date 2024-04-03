//
//  OnboardingView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct OnboardingView: View {
    
    @Binding var showOnboarding: Bool
    @State private var selection: Int = 0
    var body: some View {
        TabView(selection: $selection) {
            OnboardingPageView(imageName: "welcome", title: "Namaste", description: "Welcome to this amazing News App #NewsOnTheGo", showDoneButton: false, nextAction: goNext)
                .tag(0)
            OnboardingPageView(imageName: "latestnews", title: "Editor's Hand-Picked", description: "Whether you're at home, on the go, or anywhere in between, News Hub keeps you informed and connected to the world around you. ", showDoneButton: false, nextAction: goNext)
                .tag(1)
            OnboardingPageView(imageName: "interview", title: "Thoughtful and Focused", description: "Your go-to destination for breaking news, insightful articles, and personalized updates tailored to your interests.", showDoneButton: true, nextAction: goNext)
                .tag(2)
        }
        .tabViewStyle(.page(indexDisplayMode: .always))
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
    }
    func goNext() {
        withAnimation {
            if selection < 2 {
                selection += 1
            }
            else {
                showOnboarding = false
                do {
                    try AuthenticationManager.shared.signOut()
                } catch {
                    print("Error : \(error.localizedDescription)")
                }
            }
        }
    }
}

#Preview {
    OnboardingView(showOnboarding: .constant(false))
}
