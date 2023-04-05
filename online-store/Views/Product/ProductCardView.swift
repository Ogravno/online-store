//
//  ProductCardView.swift
//  online-store
//
//  Created by Odin Grav on 04/04/2023.
//

import Foundation
import SwiftUI

struct ProductCardView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    var product: Product
    
    var body: some View {
        NavigationLink(destination: ProductView(storeViewModel: storeViewModel, product: product)) {
            VStack(alignment: .center, spacing: 4) {
                VStack(alignment: .center) {
                    AsyncImage(url: product.thumbnail) { phase in
                        switch phase {
                        case .empty:
                            ProgressView()
                        case .success(let image):
                            image.resizable()
                                .aspectRatio(contentMode: .fit)
                                .clipShape(ContainerRelativeShape())
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
                }
                .frame(height: 150)
                
                Text(product.title)
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .lineLimit(2)
                    .foregroundColor(.black)
                
                VStack(alignment: .leading) {
                    HStack {
                        Text(product.price, format: .currency(code: "USD"))
                            .font(.system(size: 10, weight: .bold, design: .default))
                            .strikethrough()
                        
                        Text("-\(String(product.discountPercentage))%")
                            .font(.system(size: 10))
                    }
                    
                    Text(product.price - (product.price/100 * product.discountPercentage), format: .currency(code: "USD"))
                        .font(.system(size: 10, weight: .bold, design: .default))
                }
                .foregroundColor(.black)
            }
            .padding(20)
            .frame(maxWidth: .infinity, maxHeight: 400)
            .background(Color.white)
            .cornerRadius(4)
            .shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.15), radius: 4, x: 1, y: 4)
        }
    }
}
