//
//  ProfileViewModel.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import Foundation
import SwiftUI
import PhotosUI

@MainActor
final class ProfileViewModel: ObservableObject {
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws {
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
    @Published var updateEmail = ""
    @Published var updatePassword = ""
    
    func signOut() throws {
        try AuthenticationManager.shared.signOut()
    }
    
    func updateEmail() async throws {
        try await AuthenticationManager.shared.updateEmail(email: updateEmail)
    }
    
    func updatePassword() async throws {
        try await AuthenticationManager.shared.updatePassword(password: updatePassword)
    }
    
    func deleteAccount() async throws {
        guard let user else { return }
        UserManager.shared.deleteDocument(userId: user.userId)
        try await AuthenticationManager.shared.delete()
    }
    
    func saveProfileImage(item: PhotosPickerItem) {
        Task {
            guard var user else { return }
            guard let data = try await item.loadTransferable(type: Data.self) else { return }
            let (path, _) = try await StorageManager.shared.saveImage(data: data, userId: user.userId)
            user.profileImagePath = path
            try await UserManager.shared.UpdateUserProfileImage(user: user)
            self.user = try await UserManager.shared.getUser(userId: user.userId)
        }
    }
    
    func shortenDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter.string(from: date)
    }
    
}
