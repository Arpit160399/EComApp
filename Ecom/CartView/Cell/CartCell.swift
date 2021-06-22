//
//  CartCell.swift
//  Ecom
//
//  Created by Arpit Singh on 21/06/21.
//

import UIKit

class CartCell: UITableViewCell {
    private let holderView = UIView()
    let productImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFit
        image.clipsToBounds = true
        return image
    }()

    let stepper = PlainStepperControl()
    let ratingView = RatingView()
    let productName = TextLabel(frame: .zero, type: .Heading)
    let subtitleName = TextLabel(frame: .zero, type: .subtitle)
    let price = TextLabel(frame: .zero, type: .Price)
    let totalPrice = TextLabel(frame: .zero, type: .Price)
    let minQuanity = TextLabel(frame: .zero, type: .Light)
    lazy var stack = UIStackView(arrangedSubviews: [totalPrice, price, minQuanity])
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .primaryBackgroundColor
        addholderView()
        addImageview()
        addHeading()
        addSubtext()
        addRating()
        addPriceTag()
        addStepper()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addholderView() {
        contentView.addSubview(holderView)
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 8
        holderView.addTopAnchor(equal: contentView.topAnchor, constant: 5)
            .addLeftAnchor(equal: contentView.leftAnchor, constant: 20)
            .addRightAnchor(equal: contentView.rightAnchor, constant: -20)
            .addBottomAnchor(equal: contentView.bottomAnchor, constant: -5)
    }
    
    fileprivate func addImageview() {
        holderView.addSubview(productImageView)
        productImageView.addTopAnchor(equal: holderView.topAnchor, constant: 5)
            .addLeftAnchor(equal: holderView.leftAnchor, constant: 10)
            .addBottomAnchor(equal: holderView.bottomAnchor, constant: -5)
            .addWidthAnchor(constant: 50)
    }
    
    fileprivate func addHeading() {
        holderView.addSubview(productName)
        productName.addTopAnchor(equal: holderView.topAnchor, constant: 20)
            .addLeftAnchor(equal: productImageView.rightAnchor, constant: 20)
        productName.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.25).isActive = true
    }
    
    fileprivate func addSubtext() {
        holderView.addSubview(subtitleName)
        subtitleName.addTopAnchor(equal: productName.bottomAnchor, constant: 5)
            .addLeftAnchor(equal: productImageView.rightAnchor, constant: 20)
        subtitleName.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, multiplier: 0.35).isActive = true
        subtitleName.bottomAnchor.constraint(lessThanOrEqualTo: holderView.bottomAnchor, constant: -20).isActive = true
    }
    
    fileprivate func addRating() {
        holderView.addSubview(ratingView)
        ratingView.addTopAnchor(equal: productName.topAnchor)
            .addLeftAnchor(equal: productName.rightAnchor, constant: 10)
    }
    
    fileprivate func addPriceTag() {
        stack.axis = .vertical
        stack.spacing = 4
        stack.distribution = .equalCentering
        holderView.addSubview(stack)
        stack.addTopAnchor(equal: holderView.topAnchor, constant: 8)
            .addLeftAnchor(equal: subtitleName.rightAnchor, constant: 10)
            .addWidthAnchor(constant: 70)
        stack.bottomAnchor.constraint(lessThanOrEqualTo: holderView.bottomAnchor, constant: -10).isActive = true
    }
    
    fileprivate func addStepper() {
        holderView.addSubview(stepper)
        stepper.addBottomAnchor(equal: holderView.bottomAnchor)
            .addRightAnchor(equal: holderView.rightAnchor)
            .addLeftAnchor(equal: stack.rightAnchor, constant: 5)
            .addHeightAnchor(constant: 40)
        stepper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.2).isActive = true
        stepper.topAnchor.constraint(greaterThanOrEqualTo: holderView.topAnchor, constant: 20).isActive = true
    }
    
    fileprivate func stepperConfig(_ product: Product) {
        stepper.incrementAction = {
            if UserCart.shared.getItemBy(id: product.id) != nil {
                UserCart.shared.increaseQunaityOf(item: product, by: 1)
            } else {
                UserCart.shared.increaseQunaityOf(item: product, by: Float(product.minimum_quantity))
            }
        }
        stepper.decrementAction = {
            if let cartitem = UserCart.shared.getItemBy(id: product.id), Int(cartitem.quanity) <= product.minimum_quantity {
                UserCart.shared.decreaseQunaityOf(item: product, by: Float(product.minimum_quantity))
            } else {
                UserCart.shared.decreaseQunaityOf(item: product, by: 1)
            }
        }
    }
    
    func configCellWith(value: Cart) {
        let product = value.item
        productName.text = product.name
        subtitleName.text = product.alias
        minQuanity.text = "Min \(product.minimum_quantity) \(product.unit)"
        price.addTag(price: product.price, unit: product.unit)
        productImageView.image = UIImage(named: "Path")
        stepper.datalabel.text = String(Int(value.quanity))
        totalPrice.text = "Total Rs \(Int(value.totalPrice))"
        if let rating = product.rating {
            ratingView.setRating(to: rating)
        } else {
            ratingView.isHidden = true
        }
        stepperConfig(product)
    }
}
