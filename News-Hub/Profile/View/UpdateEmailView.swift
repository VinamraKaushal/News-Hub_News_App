//
//  UpdateEmailView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 28/03/24.
//

import SwiftUI

struct UpdateEmailView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showAlert: Bool = false
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("Enter new email address")
                .font(.title3)
                .fontWeight(.semibold)
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.top, 50)
                .padding(.horizontal, 26)
            ZStack {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color.gray, lineWidth: 1)
                    .frame(maxWidth: .infinity, maxHeight: 50)
                    .padding(.horizontal, 26)
                TextField("Enter your email", text: $viewModel.updateEmail)
                    .font(.subheadline)
                    .padding()
                    .cornerRadius(10)
                    .autocorrectionDisabled()
                    .autocapitalization(.none)
                    .padding(.horizontal, 26)
            }
            .padding(.bottom, 10)
            Button("Update") {
                showAlert.toggle()
            }
            .font(.title3)
            .foregroundStyle(.white)
            .frame(width: 340, height: 50)
            .background(Color(.systemRed))
            .clipShape(.capsule)
            .padding(.horizontal, 26)
            .alert(isPresented: $showAlert, content: {
                Alert(title: Text("Update Email"), message: Text("Do you really want to update the email!"), primaryButton: .default(Text("Update"), action: {
                    Task {
                        do {
                            try await viewModel.updateEmail()
                        } catch {
                            print("Error: \(error.localizedDescription)")
                        }
                        dismiss()
                    }
                }), secondaryButton: .cancel())
            })
        }
        Spacer()
    }
}

#Preview {
    UpdateEmailView()
}
