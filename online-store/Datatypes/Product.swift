//
//  Product.swift
//  online-store
//
//  Created by Odin Grav on 16/03/2023.
//

import Foundation

struct ProductMeta: Codable {
    var products: [Product]
}

struct Product: Codable, Hashable, Identifiable {
    var id: Int
    var title: String
    var price: Double
    var discountPercentage: Double
    var category: String
    var description: String
    var thumbnail: URL
    var images: [URL]
    var rating: Double
    var stock: Int
}
