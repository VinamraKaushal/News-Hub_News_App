//
//  OnboardingPageView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI

struct OnboardingPageView: View {
    let imageName: String
    let title: String
    let description: String
    let showDoneButton: Bool
    
    var nextAction: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            Image(imageName)
                .resizable()
                .frame(width: 250, height: 250, alignment: .center)
                .padding(.bottom, 10)
            Text(title)
                .font(.title)
                .multilineTextAlignment(.center)
                .bold()
                .padding(.bottom, 10)
                .frame(width: UIScreen.main.bounds.width - 50)
            Text(description)
                .font(.title3)
                .multilineTextAlignment(.center)
                .frame(width: UIScreen.main.bounds.width - 50)
                .padding(.top, 20)
                .padding(.bottom, 20)
            if showDoneButton {
                Button("Let's get started") {
                    nextAction()
                }
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemRed))
                .clipShape(.capsule)
                .padding(.horizontal, 26)
                .padding(.top, 50)
            }
            else {
                Button("Continue") {
                    nextAction()
                }
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemRed))
                .clipShape(.capsule)
                .padding(.horizontal, 26)
                .padding(.top, 50)
            }
            Spacer()
        }
    }
}

#Preview {
    OnboardingPageView(imageName: "person.fill", title: "Hello", description: "Welcome to this very amazing news app", showDoneButton: true, nextAction: {})
}


