//
//  Product.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import Foundation
struct ProductData: Codable {
    let data: [Product]
}

struct Product: Codable {
    let id: Int
    let name: String
    let rating: String?
    let category: Category
    let logo: String?
    let minimum_quantity: Int
    let alias: String
    let price: Float
    let unit: String
}
