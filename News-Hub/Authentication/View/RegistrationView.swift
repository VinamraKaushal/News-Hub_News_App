//
//  RegistrationView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI
import FirebaseAuth

struct RegistrationView: View {
    @StateObject private var viewModel = RegistrationViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        Spacer()
        Text("Create an account")
            .font(.largeTitle)
            .fontWeight(.bold)
            .frame(width: 340, alignment: .leading)
            .padding(.horizontal, 26)
            .padding(.bottom, 20)
        if !viewModel.errorMessage.isEmpty {
            Text(viewModel.errorMessage)
                .foregroundColor(Color.red)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal, 26)
        }
        Text("Name")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(width: 340, alignment: .leading)
            .padding(.horizontal, 26)
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 340, height: 50)
                .padding(.horizontal, 26)
            TextField("Enter your full name", text: $viewModel.fullName)
                .font(.subheadline)
                .padding()
                .cornerRadius(10)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .padding(.horizontal, 26)
        }
        Text("Email Address")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            .padding(.horizontal, 26)
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 340, height: 50)
                .padding(.horizontal, 26)
            TextField("Enter your email", text: $viewModel.email)
                .font(.subheadline)
                .padding()
                .cornerRadius(10)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .padding(.horizontal, 26)
        }
        Text("Password")
            .font(.title3)
            .fontWeight(.semibold)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 20)
            .padding(.horizontal, 26)
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.gray, lineWidth: 1)
                .frame(width: 340, height: 50)
                .padding(.horizontal, 26)
            SecureField("Enter your password", text: $viewModel.password)
                .font(.subheadline)
                .padding()
                .cornerRadius(10)
                .autocorrectionDisabled()
                .autocapitalization(.none)
                .padding(.horizontal, 26)
        }
        Button(action: {
            Task {
                do {
                    try await viewModel.register()
                    if Auth.auth().currentUser != nil {
                        dismiss()
                    }
                } catch {
                    print("Error: \(error.localizedDescription)")
                }
            }
        }, label: {
            Text("Register")
                .font(.title3)
                .foregroundStyle(.white)
                .frame(width: 340, height: 50)
                .background(Color(.systemRed))
                .clipShape(.capsule)
                .padding(.horizontal, 26)
        })
        .padding(.top)
        Spacer()
        HStack(spacing: -10) {
            Text("Already have an Account?")
                .font(.callout)
            Button {
                dismiss()
            } label: {
                Text("Sign in")
                    .font(.callout)
                    .foregroundStyle(Color(.systemRed))
            }
            .padding()
        }
    }
}

#Preview {
    RegistrationView()
}
