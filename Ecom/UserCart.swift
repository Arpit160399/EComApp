//
//  UserCart.swift
//  Ecom
//
//  Created by Arpit Singh on 18/06/21.
//

import Foundation
class UserCart {
    static var shared = UserCart()
    private let localStoreKey = "user_cart"
    private var localCopy = [Int : Cart]()
    var valueUpdated: (() -> Void)?
    private var currentCart = [Int : Cart]() {
        didSet {
            saveLocaly()
        }
    }
    
    init(){
        if let data = UserDefaults.standard.object(forKey: localStoreKey) as? Data {
            if let cartValue = try? JSONDecoder().decode([Int : Cart].self, from: data) {
                localCopy = cartValue
                currentCart = cartValue
            }
        }
    }
    
  private func addtoCart(item: Product,quaninty: Float) {
      let cart = Cart(quanity: 1, totalPrice: item.price, item: item)
      currentCart[item.id] = cart
      currentCart[item.id]?.quanity = quaninty
      print(item)
    }
    
   private func removeFromCart(item: Product) {
       currentCart[item.id] = nil
    }
    
    fileprivate func updatePrice(id: Int,price: Float) {
        let qunaity = currentCart[id]?.quanity ?? 1
        currentCart[id]?.totalPrice = price * qunaity
    }
    
func increaseQunaityOf(item: Product,by: Float) {
        print(item)
        if  currentCart[item.id] != nil {
            currentCart[item.id]?.quanity += by
            updatePrice(id: item.id,price: item.price)
            saveLocaly()
        } else {
            addtoCart(item: item, quaninty: by)
        }
       valueUpdated?()
    }
    
    func decreaseQunaityOf(item: Product,by: Float) {
        currentCart[item.id]?.quanity -= by
        if let cart = currentCart[item.id] {
            if  cart.quanity < 1 {
             removeFromCart(item: item)
            }
        }
        updatePrice(id: item.id,price: item.price)
        saveLocaly()
        valueUpdated?()
    }
    
    func getItemBy(id: Int) -> Cart? {
        return currentCart[id]
    }
    
    func getCartItem() -> [Cart] {
        return currentCart.values.compactMap { $0 }
    }
    

    private func saveLocaly() {
        if let jsonData = try? JSONEncoder().encode(currentCart), localCopy != currentCart {
            UserDefaults.standard.set(jsonData, forKey: localStoreKey)
            localCopy = currentCart
        }
    }

}
