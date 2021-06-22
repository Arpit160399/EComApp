//
//  ProductCell.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class ProductCell: UICollectionViewCell, TempleteCollectioViewCell {
    static var cellIdentiffer: String = "ProductCell"
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
    let minQuanity = TextLabel(frame: .zero, type: .Light)
 
    fileprivate func addholderView() {
        contentView.addSubview(holderView)
        holderView.backgroundColor = .white
        holderView.layer.cornerRadius = 8
        holderView.addTopAnchor(equal: topAnchor, constant: 20)
            .addLeftAnchor(equal: leftAnchor, constant: 20)
            .addRightAnchor(equal: rightAnchor, constant: -20)
            .addBottomAnchor(equal: bottomAnchor, constant: -20)
    }
    
    fileprivate func addMinQuanity() {
        holderView.addSubview(minQuanity)
        minQuanity
            .addTopAnchor(equal: holderView.topAnchor,constant: 5)
            .addRightAnchor(equal: holderView.rightAnchor, constant: -15)
    }
    
    fileprivate func addProducImage() {
        holderView.addSubview(productImageView)
        productImageView.addTopAnchor(equal: minQuanity.bottomAnchor)
            .addLeftAnchor(equal: holderView.leftAnchor)
            .addRightAnchor(equal: holderView.rightAnchor)
            .addHeightAnchor(constant: 100)
    }
    
    fileprivate func addHeading() {
        holderView.addSubview(productName)
        productName.addTopAnchor(equal: productImageView.bottomAnchor, constant: 10)
            .addLeftAnchor(equal: holderView.leftAnchor, constant: 15)
        productName.widthAnchor.constraint(lessThanOrEqualToConstant: contentView.frame.width * 0.5).isActive = true
    }
    
    fileprivate func addSubtitle() {
        holderView.addSubview(subtitleName)
        subtitleName.addTopAnchor(equal: productName.bottomAnchor, constant: 6)
            .addLeftAnchor(equal: holderView.leftAnchor, constant: 15)
            .addRightAnchor(equal: holderView.rightAnchor, constant: -15)
    }
    
    fileprivate func addPricetag() {
        holderView.addSubview(price)
        price.addTopAnchor(equal: subtitleName.bottomAnchor, constant: 6)
            .addLeftAnchor(equal: holderView.leftAnchor, constant: 15)
            .addRightAnchor(equal: holderView.rightAnchor, constant: -15)
    }
    
    fileprivate func addStepper() {
        holderView.addSubview(stepper)
        stepper.addBottomAnchor(equal: holderView.bottomAnchor)
            .addRightAnchor(equal: holderView.rightAnchor)
            .addTopAnchor(equal: price.bottomAnchor, constant: 5)
            .addHeightAnchor(constant: 30)
        stepper.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4).isActive = true
    }
    
    fileprivate func addratinView() {
        holderView.addSubview(ratingView)
        ratingView.addTopAnchor(equal: productImageView.bottomAnchor, constant: 10)
            .addLeftAnchor(equal: productName.rightAnchor, constant: 10)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addholderView()
        addMinQuanity()
        addProducImage()
        addHeading()
        addSubtitle()
        addPricetag()
        addratinView()
        addStepper()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setQuianity(_ product: Product) {
        if let cartitem = UserCart.shared.getItemBy(id: product.id) {
            stepper.datalabel.text = String(Int(cartitem.quanity))
        } else {
            stepper.datalabel.text = "0"
        }
    }
    
    fileprivate func stepperConfig(_ product: Product) {
        stepper.incrementAction = { [weak self] in
            if UserCart.shared.getItemBy(id: product.id) != nil {
                UserCart.shared.increaseQunaityOf(item: product, by: 1)
            } else {
                UserCart.shared.increaseQunaityOf(item: product, by: Float(product.minimum_quantity))
            }
            self?.setQuianity(product)
        }
        stepper.decrementAction = { [weak self] in
            if let cartitem = UserCart.shared.getItemBy(id: product.id), Int(cartitem.quanity) <= product.minimum_quantity {
                UserCart.shared.decreaseQunaityOf(item: product, by: Float(product.minimum_quantity))
            } else {
                UserCart.shared.decreaseQunaityOf(item: product, by: 1)
            }
            self?.setQuianity(product)
        }
    }
    
    func configCellWith(value: Any) {
        if let product = value as? Product {
            productName.text = product.name
            subtitleName.text = product.alias
            minQuanity.text = "Min \(product.minimum_quantity) \(product.unit)"
            price.addTag(price: product.price, unit: product.unit)
            productImageView.image = UIImage(named: "Path")
            setQuianity(product)
//            if let rating = product.rating {
            ratingView.setRating(to: String(Int.random(in: 1 ... 5)))
//            } else {
//            ratingView.isHidden = true
//            }
            stepperConfig(product)
        }
    }
}
