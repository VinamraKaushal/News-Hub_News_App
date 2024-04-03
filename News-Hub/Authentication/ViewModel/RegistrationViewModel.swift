//
//  LoginViewModel.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation

@MainActor
final class RegistrationViewModel: ObservableObject {
    @Published var fullName = ""
    @Published var email = ""
    @Published var password = ""
    @Published var errorMessage = ""
    
    init() {}
    
    @MainActor
    func register() async throws {
        guard validate() else {
            return
        }
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(fullName: fullName, userId: authDataResult.uid, email: authDataResult.email, photoUrl: authDataResult.photoUrl, dateCreated: Date())
        try await UserManager.shared.createNewUser(user: user)
    }
    
    private func validate() -> Bool {
        guard !fullName.trimmingCharacters(in: .whitespaces).isEmpty,
              !email.trimmingCharacters(in: .whitespaces).isEmpty,
              !password.trimmingCharacters(in: .whitespaces).isEmpty else {
            errorMessage = "Please fill in all fields."
            return false
        }
        guard email.contains("@") && email.contains(".") else {
            errorMessage = "Please enter valid email address."
            return false
        }
        guard password.count >= 6 else {
            errorMessage = "Password less than 6 digits."
            return false
        }
        return true
    }
}
