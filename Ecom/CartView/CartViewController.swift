//
//  CartViewController.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class CartController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    lazy var tabelView = UITableView(frame: view.frame)
    let cell = "CartCell"
    var products = [Cart]()  {
        didSet {
            tabelView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
        navigationController?.setPlainNaviagtionBar(title: "Cart")
        addTabelView()
    }
    
    fileprivate func setBillingCart() {
        products = UserCart.shared.getCartItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBillingCart()
        UserCart.shared.valueUpdated = setBillingCart
    }
    
    
    fileprivate func addTabelView() {
        tabelView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview(tabelView)
        tabelView.backgroundColor = .primaryBackgroundColor
        tabelView.separatorStyle = .none
        tabelView.register(CartCell.self, forCellReuseIdentifier: cell)
        tabelView.dataSource = self
        tabelView.delegate = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cart = products[indexPath.row]
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cell) as? CartCell else {
            return UITableViewCell()
        }
        cell.configCellWith(value: cart)
        return cell
    }

}
