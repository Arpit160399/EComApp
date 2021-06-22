//
//  DataSourceProvide.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import Foundation

class DataSourceProvider {
    static let stander = DataSourceProvider()
    let testName = ["Root", "Fruit Vegetable", "Green", "Fruit Vegetable", "Fungus", "Baby Vegetable"]
    var catgoreySet: Set<Category> = []
    var productCollection = [Int: [Product]]()
    fileprivate func setValues<T: Codable>(compeltion: @escaping (Result<T, Error>) -> Void) {
        guard let url = URL(string: "https://staging.madrasmandi.zethic.com/api/interview-task") else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: urlRequest) { data, urlRes, error in
            let result: Result<T, Error>
            if error != nil {
                result = .failure(error!)
                compeltion(result)
                return
            } else if let res = urlRes as? HTTPURLResponse, res.statusCode == 200 {
                do {
                    guard let data = data else {
                        result = .failure(NSError(domain: "No Data Found", code: 404, userInfo: nil))
                        compeltion(result)
                        return
                    }
                    let model = try JSONDecoder().decode(T.self, from: data)
                    result = .success(model)
                    compeltion(result)
                } catch {
                    result = .failure(error)
                    compeltion(result)
                }
            } else {
                result = .failure(NSError(domain: "internal Server Error", code: 500, userInfo: nil))
                compeltion(result)
            }
        }
        task.resume()
    }

    func config() {}

    func getCategory(compiletion: @escaping ([Category]?, Error?) -> Void) {
        productCollection = [:]
        setValues { (result: Result<ProductData, Error>) in
            switch result {
            case .success(let success):
                success.data.forEach { product in
                    self.catgoreySet.insert(product.category)
                    let id = product.category.id
                    if self.productCollection[id] != nil {
                        self.productCollection[id]?.append(product)
                    } else {
                        self.productCollection[id] = [product]
                    }
                }
                let array = self.catgoreySet.map { categor in
                    categor
                }
                DispatchQueue.main.async {
                    compiletion(array, nil)
                }
            case .failure(let failure):
                print(failure)
                DispatchQueue.main.async {
                    compiletion(nil, failure)
                }
            }
        }
    }

    func getProductList(ofcategory: Int, page: Int = 0, compiletion: @escaping ([Product]?, Error?) -> Void) {
        let productList = productCollection[ofcategory] ?? []
        let limit = page > 0 ? 6 : 12
        let start = limit * page
        let end = start + limit
        let pageItems = sliceArray(products: productList, start: start, end: end)
        DispatchQueue.main.asyncAfter(wallDeadline: .now() + 2) {
            compiletion(pageItems, nil)
        }
    }
    
    fileprivate func sliceArray(products: [Product],start: Int,end: Int) -> [Product] {
        if start < products.count, products.count > end {
            let pageItems = products[start ... end].map { $0 }
            return pageItems
        } else if start < products.count{
            let pageItems = products[start...].map { $0 }
            return pageItems
        
        } else {
            return []
        }
    }
}
