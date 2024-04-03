//
//  ProfileView.swift
//  News-Hub
//
//  Created by Vinamra Kaushal on 27/03/24.
//

import SwiftUI
import PhotosUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    @State private var showAlert: Bool = false
    @State private var alert: Bool = false
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var image: UIImage? = nil
    
    var body: some View {
        VStack {
            PhotosPicker(selection: $selectedItem, matching: .images, photoLibrary: .shared()) {
                if let image {
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: 150, height: 150)
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .clipShape(Circle())
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                    }
                } else {
                    ZStack {
                        Circle()
                            .stroke(Color.gray, lineWidth: 2)
                            .frame(width: 150, height: 150)
                            .padding(.top, 20)
                            .padding(.bottom, 20)
                        Image(systemName: "person.fill")
                            .resizable()
                            .foregroundStyle(Color(.systemGray))
                            .frame(width: 80, height: 80, alignment: .center)
                    }
                }
            }
            if let user = viewModel.user {
                Text(user.fullName ?? "new_user")
                    .font(.title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 26)
                Text("Date Created : \(viewModel.shortenDate(user.dateCreated!))")
                    .font(.title3)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.horizontal, 26)
            }
            List {
                Section {
                    NavigationLink {
                        UpdatePasswordView()
                    } label: {
                        Text("Change Password")
                    }
                    NavigationLink {
                        UpdateEmailView()
                    } label: {
                        Text("Change Email")
                    }
                    Button("Delete Account") {
                        showAlert.toggle()
                    }.alert(isPresented: $showAlert, content: {
                        Alert(title: Text("Delete Account"),
                              message: Text("Do you really want to delete the account permanently?"),
                              primaryButton: .destructive(Text("Delete"), action: {
                            Task {
                                do {
                                    try await viewModel.deleteAccount()
                                } catch {
                                    print("Error: \(error.localizedDescription)")
                                }
                            }
                        }),
                              secondaryButton: .cancel())
                    })
                } header: {
                    Text("Settings")
                        .font(.headline)
                }
            }
            .scrollContentBackground(.hidden)
            Button {
                Task {
                    do {
                        try viewModel.signOut()
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Sign Out")
                    .font(.title3)
                    .foregroundStyle(.white)
                    .frame(width: 340, height: 50)
                    .background(Color(.systemRed))
                    .clipShape(.capsule)
                    .padding(.horizontal, 26)
                    .padding(.bottom, 50)
            }
        }.task {
            Task {
                try? await viewModel.loadCurrentUser()
                if let user = viewModel.user, let path = user.profileImagePath {
                    let image = try? await StorageManager.shared.getImage(userId: user.userId, path: path)
                    self.image = image
                }
            }
        }
        .onChange(of: selectedItem) {
            Task {
                if let selectedItem, let data = try? await selectedItem.loadTransferable(type: Data.self) {
                    if let pickerImage = UIImage(data: data) {
                        image = pickerImage
                    }
                }
            }
            if let selectedItem {
                viewModel.saveProfileImage(item: selectedItem)
            }
        }
    }
}

#Preview {
    ProfileView()
}
