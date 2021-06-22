//
//  LoaderCell.swift
//  Ecom
//
//  Created by Arpit Singh on 21/06/21.
//

import UIKit

class loaderView: UICollectionReusableView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addLoadingView(activeload: UIActivityIndicatorView) {
        self.addSubview(activeload)
        activeload.color = .black
        backgroundColor = .primaryBackgroundColor
        activeload.addXCenterAnchor(equal: centerXAnchor)
            .addYCenterAnchor(equal: centerYAnchor)
    }
}
