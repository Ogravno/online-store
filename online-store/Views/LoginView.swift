//
//  LoginView.swift
//  online-store
//
//  Created by Odin Grav on 23/03/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    
    @State var username: String = "" // atuny0
    @State var password: String = "" // 9uQFF1Lh
    
    @State var showPassword: Bool = false
    
    
    var body: some View {
        VStack {
            NavigationView{
                Form {
                    Section {
                        TextField("username", text: $username)
                        
                        HStack {
                            if (showPassword) {
                                TextField("password", text: $password)
                            }
                            else {
                                SecureField("password", text: $password)
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
                    
                    Section {
                        HStack {
                            Spacer()
                            Button(action: {
                                Task {
                                    await storeViewModel.login(username: username, password: password)
                                }
                            }, label: {
                                Text("Log in")
                            })
                            Spacer()
                        }
                    }
                }
                .navigationTitle("Log in")
            }
        }
    }
}
