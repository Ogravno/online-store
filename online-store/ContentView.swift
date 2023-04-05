//
//  ContentView.swift
//  online-store
//
//  Created by Odin Grav on 16/03/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var storeViewModel: StoreViewModel = StoreViewModel()
    
    var body: some View {
        if (storeViewModel.token == "") {
            LoginView(storeViewModel: storeViewModel)
        }
        
        else {
            TabView {
                ProductsView(storeViewModel: storeViewModel)
                    .tabItem {
                        Image(systemName: "house.fill")
                        Text("Home")
                    }
                
                CartView(storeViewModel: storeViewModel)
                    .tabItem {
                        Image(systemName: "cart.fill")
                        Text("Cart")
                    }
                
                ProfileView(storeVievModel: storeViewModel)
                    .tabItem {
                        Image(systemName: "person.crop.circle")
                        Text("Profile")
                    }
            }
            .task {
                await storeViewModel.setCart()
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
