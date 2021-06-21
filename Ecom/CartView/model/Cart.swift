//
//  Cart.swift
//  Ecom
//
//  Created by Arpit Singh on 18/06/21.
//

import Foundation
struct Cart: Codable,Equatable {
    static func == (lhs: Cart, rhs: Cart) -> Bool {
        return lhs.item.name == rhs.item.name
    }
    var quanity: Float
    var totalPrice: Float
    var item: Product
}
