//
//  Product.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import Foundation
struct Product: Codable {
    let id: String
    let name: String
    let rating: String?
    let categoryID: String
    let imageurl: String
    let minQuanity: Int
    let subtext: String
    let price: Float
    let uints: String
}
