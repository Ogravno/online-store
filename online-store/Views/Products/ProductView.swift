//
//  ProductView.swift
//  online-store
//
//  Created by Odin Grav on 16/03/2023.
//

import SwiftUI

struct ProductView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    var product: Product
    
    var body: some View {
        ScrollView {
            VStack {
                ImageSliderView(images: product.images)
                    .frame(height: 200)
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(product.title)
                        .font(.title)
                        .lineLimit(2)
                    
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            HStack {
                                Text(product.price, format: .currency(code: "USD"))
                                    .font(.headline.bold())
                                    .strikethrough()
                                
                                Text("-\(String(product.discountPercentage))%")
                            }
                            
                            Text(product.price - (product.price/100 * product.discountPercentage), format: .currency(code: "USD"))
                                .font(.headline.bold())
                        }
                        
                        Spacer()
                        
                        StarsView(rating: product.rating, maxRating: 5)
                            .frame(width: 80)
                    }
                    
                    Button(action: {storeViewModel.addToCart(product: product)}) {
                        Text("Add to cart")
                            .padding()
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                    }
                    .background(Color(.black))
                    .cornerRadius(10)
                    
                    Text("Stock: \(product.stock)")
                    
                    Text(product.description)
                        .font(.body)
                }
            }
            .padding()
            Spacer()
        }
    }
}



