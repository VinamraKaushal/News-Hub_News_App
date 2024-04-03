//
//  RootViewModel.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 03/04/24.
//

import Foundation

import Firebase
import FirebaseAuth
import Combine

class RootViewModel: ObservableObject {
    @Published var userSession: FirebaseAuth.User?
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        setupSubscribers()
    }
    
    private func setupSubscribers() {
        AuthenticationManager.shared.$userSessions.sink { [weak self] userSessionFromAuthService in
            self?.userSession = userSessionFromAuthService
        }.store(in: &cancellables)
    }
}
