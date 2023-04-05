//
//  CartView.swift
//  online-store
//
//  Created by Odin Grav on 24/03/2023.
//

import SwiftUI

struct CartView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    
    var total: Double {
        (storeViewModel.cart.products?.map {
            let totalPrice = $0.price * Double($0.quantity)
            return totalPrice - (totalPrice/100 * $0.discountPercentage)
        } ?? []).reduce(0, +)
    }
    
    var body: some View {
        VStack {
            NavigationView {
                List(storeViewModel.cart.products ?? [], id: \.self) { product in
                    CartItemView(product: product)
                }
                .navigationTitle("Your cart")
            }
            Section {
                VStack() {
                    HStack {
                        Text("Total: ")
                        Text((total), format: .currency(code: "USD"))
                            .font(.headline.bold())
                        
                    }
                    .padding()
                }
            }
        }
    }
}

