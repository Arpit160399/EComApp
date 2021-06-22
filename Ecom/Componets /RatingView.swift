//
//  RatingView.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class RatingView: UIView {
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .yellowGold
        addSubview(ratingLabel)
        ratingLabel.addTopAnchor(equal: topAnchor, constant: 2)
        ratingLabel.addLeftAnchor(equal: leftAnchor, constant: 6)
        ratingLabel.addRightAnchor(equal: rightAnchor, constant: -6)
        ratingLabel.addBottomAnchor(equal: bottomAnchor, constant: -2)
        layer.cornerRadius = 3
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setRating(to: String) {
        let fortext = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 11, weight: .semibold), NSAttributedString.Key.foregroundColor: UIColor.white]
        let formate = NSMutableAttributedString()
        formate.append(NSAttributedString(string: "\u{2605}", attributes: fortext))
        formate.append(NSAttributedString(string: to, attributes: fortext))
        ratingLabel.attributedText = formate
    }
}
