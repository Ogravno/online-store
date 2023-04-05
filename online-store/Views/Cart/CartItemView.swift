//
//  CartItemView.swift
//  online-store
//
//  Created by Odin Grav on 05/04/2023.
//

import SwiftUI

struct CartItemView: View {
    var product: CartProduct
    
    var totalPrice: Double {
        product.price * Double(product.quantity)
    }
    
    var body: some View {
        Section {
            VStack(alignment: .leading) {
                Text(product.title)
                    .font(.title)
                
                HStack {
                    VStack(alignment: .leading) {
                        Text("Quantity:")
                        Text(String(product.quantity))
                    }
                    
                    Spacer()
                    
                    VStack(alignment: .leading) {
                        Text("Total:")
                        Text(totalPrice, format: .currency(code: "USD"))
                            .strikethrough()
                        
                        Text(totalPrice - (totalPrice/100 * product.discountPercentage), format: .currency(code: "USD"))
                    }
                }
            }
        }
    }
}

