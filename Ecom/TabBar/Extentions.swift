//
//  Extentions.swift
//  Ecom
//
//  Created by Arpit Singh on 19/06/21.
//

import UIKit
extension UIColor {
    static let primaryBackgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
    static let yellowGold = UIColor(red: 254/255, green: 153/255, blue: 0, alpha: 1)
    static let plaingray = UIColor(red: 231/255, green: 231/255, blue: 231/255, alpha: 1)
    static let lightBlack = UIColor(red: 35/255, green: 40/255, blue: 39/255, alpha: 1)
}

extension UINavigationController {
    func setPlainNaviagtionBar(title: String) {
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.barTintColor = .primaryBackgroundColor
        self.navigationBar.topItem?.title = title
        self.navigationBar.prefersLargeTitles = true
        self.navigationBar.largeTitleTextAttributes = [.font: UIFont.systemFont(ofSize: 32, weight: .semibold), .foregroundColor: UIColor.black]
    }
}

extension UIView {
    @discardableResult func addTopAnchor(equal: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.topAnchor.constraint(equalTo: equal, constant: constant).isActive = true
        return self
    }

    @discardableResult func addBottomAnchor(equal: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.bottomAnchor.constraint(equalTo: equal, constant: constant).isActive = true
        return self
    }

    @discardableResult func addLeftAnchor(equal: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.leftAnchor.constraint(equalTo: equal, constant: constant).isActive = true
        return self
    }

    @discardableResult func addRightAnchor(equal: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.rightAnchor.constraint(equalTo: equal, constant: constant).isActive = true
        return self
    }

    @discardableResult func addXCenterAnchor(equal: NSLayoutAnchor<NSLayoutXAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerXAnchor.constraint(equalTo: equal, constant: constant).isActive = true
        return self
    }

    @discardableResult func addYCenterAnchor(equal: NSLayoutAnchor<NSLayoutYAxisAnchor>, constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.centerYAnchor.constraint(equalTo: equal, constant: constant).isActive = true
        return self
    }

    @discardableResult func addHeightAnchor(constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.heightAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }

    @discardableResult func addWidthAnchor(constant: CGFloat = 0) -> UIView {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: constant).isActive = true
        return self
    }
}

extension String {
    func textSizeReqired(givensize: CGSize, font: UIFont) -> CGSize {
        let neededSize = NSString(string: self).boundingRect(with: givensize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return neededSize.size
    }
}

extension UIView {
    func addActivityView(activityLoader: UIActivityIndicatorView) {
        activityLoader.startAnimating()
        self.addSubview(activityLoader)
        activityLoader.addTopAnchor(equal: self.topAnchor)
            .addBottomAnchor(equal: self.bottomAnchor).addLeftAnchor(equal: self.leftAnchor)
            .addRightAnchor(equal: self.rightAnchor)
    }

    func removeAcivityView(activityLoader: UIActivityIndicatorView) {
        self.subviews.forEach { view in
            if view == activityLoader {
                view.removeFromSuperview()
            }
        }
    }
}
