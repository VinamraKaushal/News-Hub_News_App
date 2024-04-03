//
//  LoginViewModel.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation
import FirebaseAuth

final class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}

    @MainActor
    func signIn() async throws {
        guard validate() else {
            return
        }
        guard !email.isEmpty, !password.isEmpty else {
            return
        }
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    private func validate() -> Bool {
        errorMessage = ""
        guard !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email address."
            return false
        }
        return true
    }
}
