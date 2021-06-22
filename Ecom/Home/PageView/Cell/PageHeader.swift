//
//  PageSegment.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class PageHeadercell: UICollectionViewCell, TempleteCollectioViewCell {
    static var cellIdentiffer: String = "pageHeadercell"
    private var width: NSLayoutConstraint?
    let nameLable: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .semibold)
        label.textColor = .systemGray5
        return label
    }()

    let bottomBar: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        view.addHeightAnchor(constant: 3)
        return view
    }()
    
    override var isSelected: Bool {
        didSet {
            nameLable.textColor = isSelected ? .black : .systemGray5
            animateSelectionBar(show: isSelected)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .primaryBackgroundColor
        contentView.addSubview(nameLable)
        nameLable.addTopAnchor(equal: contentView.topAnchor)
            .addBottomAnchor(equal: contentView.bottomAnchor, constant: -3)
            .addLeftAnchor(equal: contentView.leftAnchor, constant: 8)
            .addRightAnchor(equal: contentView.rightAnchor, constant: -8)
        contentView.addSubview(bottomBar)
        bottomBar.addBottomAnchor(equal: contentView.bottomAnchor)
        bottomBar.addXCenterAnchor(equal: contentView.centerXAnchor)
        width = bottomBar.widthAnchor.constraint(equalToConstant: 0)
        width?.isActive = true
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configCellWith(value: Any) {
        if let category = value as? Category {
            nameLable.text = category.name
        }
    }
    
    fileprivate func animateSelectionBar(show: Bool) {
        width?.isActive = false
        width?.constant = show ? contentView.frame.width - 16 : 0
        width?.isActive = true
        UIView.animate(withDuration: 0.2, delay: 0, options: .curveLinear) {
            self.layoutIfNeeded()
        }
    }
}
