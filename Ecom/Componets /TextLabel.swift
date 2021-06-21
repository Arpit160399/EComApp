//
//  CustomLabel.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class TextLabel: UILabel {
     
    enum labelType {
      case Heading
      case subtitle
      case Price
      case Light
    }
    
    convenience init(frame: CGRect,type: labelType) {
        self.init(frame: frame)
        switch type {
        case .Heading:
            self.font = UIFont.systemFont(ofSize: 15, weight: .bold)
            self.numberOfLines = 0
        case .subtitle:
            self.font = UIFont.systemFont(ofSize: 11, weight: .medium)
            self.textColor = .lightBlack
            self.numberOfLines = 0
        case .Price:
            self.font = UIFont.systemFont(ofSize: 11, weight: .bold)
        case .Light:
            self.font = UIFont.systemFont(ofSize: 11, weight: .regular)
            self.textColor = .systemGray3
        }
    }

    func addTag(price: Float,unit: String){
        self.text = "Rs \(Int(price)) / \(unit)"
    }

    override init(frame: CGRect){
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
