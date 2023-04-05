//
//  ProfileView.swift
//  online-store
//
//  Created by Odin Grav on 27/03/2023.
//

import SwiftUI

struct ProfileView: View {
    @ObservedObject var storeVievModel: StoreViewModel
    
    @State var password: String = ""
    @State var showPassword: Bool = false
    
    var body: some View {
        VStack(alignment: .center) {
            AsyncImage(url: storeVievModel.user.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                case .success(let image):
                    image.resizable()
                        .frame(width: 50, height: 50)
                        .clipShape(Circle())
                case .failure:
                    Image(systemName: "photo")
                @unknown default:
                    // Since the AsyncImagePhase enum isn't frozen,
                    // we need to add this currently unused fallback
                    // to handle any new cases that might be added
                    // in the future:
                    EmptyView()
                }
            }
            
            Text(storeVievModel.user.username ?? "username")
                .font(.headline)
            Text(storeVievModel.user.email ?? "email")
                .font(.caption)
            
            NavigationView {
                Form {
                    Section {
                        HStack {
                            Text("First name: ")
                                .foregroundColor(.gray)
                            Text(storeVievModel.user.firstName ?? "")
                        }
                        
                        HStack {
                            Text("Last name: ")
                                .foregroundColor(.gray)
                            Text(storeVievModel.user.lastName ?? "")
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Age: ")
                                .foregroundColor(.gray)
                            Text(String(storeVievModel.user.age ?? 0))
                        }
                        
                        HStack {
                            Text("Gender: ")
                                .foregroundColor(.gray)
                            Text(storeVievModel.user.gender ?? "")
                        }
                        
                        HStack {
                            Text("Birthdate: ")
                                .foregroundColor(.gray)
                            Text(storeVievModel.user.birthDate ?? "")
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("E-mail: ")
                                .foregroundColor(.gray)
                            Text(storeVievModel.user.email ?? "")
                        }
                        
                        HStack {
                            Text("Phone: ")
                                .foregroundColor(.gray)
                            Text(storeVievModel.user.phone ?? "")
                        }
                    }
                    
                    Section {
                        HStack {
                            Text("Password: ")
                                .foregroundColor(.gray)
                            if (showPassword) {
                                Text(storeVievModel.user.password ?? "")
                            }
                            
                            else {
                                SecureField("password", text: $password)
                                    .disabled(true)
                            }
                            
                            Spacer()
                            
                            Button(action: {
                                showPassword.toggle()
                            }) {
                                Image(systemName: showPassword ? "eye" : "eye.slash")
                                    .accentColor(.gray)
                            }
                        }
                    }
                }
            }
            .task {
                await storeVievModel.setUserDetails()
                password =  storeVievModel.user.password ?? ""
            }
        }
    }
}
