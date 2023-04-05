//
//  CartInfo.swift
//  online-store
//
//  Created by Odin Grav on 24/03/2023.
//

import Foundation

struct CartMeta: Codable {
    var carts: [Cart]
}

struct Cart: Codable {
    var id: Int?
    var products: [CartProduct]?
}

struct CartProduct: Codable, Hashable {
    var id: Int
    var title: String
    var price: Double
    var quantity: Int
    var discountPercentage: Double
}
