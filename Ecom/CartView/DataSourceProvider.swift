//
//  DataSourceProvide.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import Foundation

class DataSourceProvider {

    static let stander = DataSourceProvider()
    let testName = ["Root", "Fruit Vegetable","Green","Fruit Vegetable","Fungus","Baby Vegetable"]
    func getCategory(compiletion: @escaping ([Category]?,Error?) -> Void) {
        var categoryList = [Category]()
        testName.enumerated().forEach { index,name in
            categoryList.append(Category(id: String(index), name: name))
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
             compiletion(categoryList,nil)
        }
    }
        
    func getProductList(ofcategory: String,page: Int = 0,compiletion: @escaping([Product]?,Error?) -> Void) {
        var productList = [Product]()
        let limit = page > 0 ? 6 : 12
        let start = limit * page
        let end = start + limit
        for x in start...end {
            productList.append(Product(id: ofcategory + "\(x)", name: "Radish", rating: nil,categoryID: ofcategory, imageurl: "Path", minQuanity: 1, subtext: "Fresh red radish", price: 120, uints: "Kg"))
        }
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 3) {
             compiletion(productList,nil)
        }
    }
}
