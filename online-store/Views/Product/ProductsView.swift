//
//  ProductsView.swift
//  online-store
//
//  Created by Odin Grav on 17/03/2023.
//

import SwiftUI

struct ProductsView: View {
    @ObservedObject var storeViewModel: StoreViewModel
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(storeViewModel.products, id: \.self) { product in
                        ProductCardView(storeViewModel: storeViewModel, product: product)
                    }
                    .navigationTitle("Products")
                }
                .padding(20)
            }
            .task {
                await storeViewModel.setProducts()
            }
            .refreshable {
                do {
                    await storeViewModel.setProducts()
                }
            }
        }
    }
}

