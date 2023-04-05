//
//  LoginView.swift
//  online-store
//
//  Created by Odin Grav on 23/03/2023.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    
    @State var username: String = "atuny0"
    @State var password: String = "9uQFF1Lh"
    
    
    var body: some View {
        VStack {
            NavigationView{
                Form {
                    Section {
                        TextField("username", text: $username)
                        // atuny0
                        SecureField("password", text: $password)
                        // 9uQFF1Lh
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
