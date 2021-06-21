//
//  CTabBar.swift
//  Ecom
//
//  Created by Arpit Singh on 19/06/21.
//

import UIKit
class ExapandingTabBar: UIView {
    var tabBarItems = [UIButton]()
    var font = UIFont.systemFont(ofSize: 11, weight: .regular)
    var makeCurrentTabAction: ((_ tab: Int) -> Void)?
    private var tabItem = [TabBarItem]()
    private var widthAnchorCollection = [NSLayoutConstraint]()
    private var activeColor = UIColor.systemGray5
    private var tabBarView = UIView()
    private var activeTab = 0
    private var iconHeingh: CGFloat = 40

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    convenience init(menuItems: [TabBarItem], frame: CGRect) {
        self.init(frame: frame)
        tabItem = menuItems
        iconHeingh = frame.height * 0.45
        createTabView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    private func createTabView() {
        tabBarView = UIView()
        tabBarView.backgroundColor = .white
        tabBarView.translatesAutoresizingMaskIntoConstraints = false
        tabBarView.layer.shadowPath = UIBezierPath(rect: frame).cgPath
        tabBarView.layer.shadowOpacity = 0.3
        tabBarView.layer.shadowOffset = .init(width: 0, height: -3.0)
        addSubview(tabBarView)
        NSLayoutConstraint.activate([
            tabBarView.topAnchor.constraint(equalTo: topAnchor),
            tabBarView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tabBarView.leftAnchor.constraint(equalTo: leftAnchor),
            tabBarView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        createMenuItem(tabItem: tabItem)
    }
    
    private func createMenuItem(tabItem: [TabBarItem]) {
        tabBarItems = []
        widthAnchorCollection = []
        tabItem.enumerated().forEach { (index,tabItem) in
            let view = createTabItem(item: tabItem)
            view.tag = index
            tabBarItems.append(view)
        }
        let stack = UIStackView(arrangedSubviews: tabBarItems)
        stack.axis = .horizontal
        stack.spacing = 12
        stack.center = center
        tabBarView.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.centerXAnchor.constraint(equalTo: tabBarView.centerXAnchor).isActive = true
        stack.heightAnchor.constraint(equalToConstant: iconHeingh) .isActive = true
        stack.centerYAnchor.constraint(equalTo: tabBarView.centerYAnchor).isActive = true
        activateTab(activeTab)
    }
    
    private func textWidthReqired(text: String) -> CGFloat {
        let availableWidth : CGFloat =  ( frame.width/CGFloat(tabBarItems.count) - iconHeingh)
        let frameSize = CGSize(width: availableWidth, height: iconHeingh)
        let neededSize = NSString(string: text).boundingRect(with: frameSize, options: .usesLineFragmentOrigin, attributes: [.font: font], context: nil)
        return neededSize.width
    }

    private func createTabItem(item: TabBarItem) -> UIButton {
        let button = UIButton()
        button.setImage(item.icon, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.imageView?.tintColor = .black
        button.titleLabel?.font = font
        button.layer.cornerRadius =  iconHeingh/2
        button.setTitleColor(UIColor.black, for: .normal)
        button.imageEdgeInsets = .init(top: 10, left: 0, bottom: 10, right: 15)
        button.addTarget(self, action: #selector(handelTap(_:)), for: .touchUpInside)
        let width = button.widthAnchor.constraint(equalToConstant: iconHeingh)
        width.isActive = true
        widthAnchorCollection.append(width)
        return button
    }

    @objc func handelTap(_ sender: UIButton) {
        switchTab(from: activeTab, to: sender.tag)
    }
    
    fileprivate func switchTab(from: Int , to: Int){
        deactivateTab(from)
        activateTab(to)
    }
    
    fileprivate func activateTab(_ index: Int) {
        let title = tabItem[index].title
        let newWidth = textWidthReqired(text: title) + iconHeingh + 20
        widthAnchorCollection[index].isActive = false
        widthAnchorCollection[index].constant = newWidth
        widthAnchorCollection[index].isActive = true
        tabBarItems[index].setTitle(title, for: .normal)
        activeTab = index
        UIView.animate(withDuration: 0.4, delay: 0.2, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
            self.tabBarItems[index].backgroundColor = self.activeColor
        }, completion: nil)
        self.makeCurrentTabAction?(index)
    }
    
    fileprivate func deactivateTab(_ index: Int){
        tabBarItems[index].setTitle(nil, for: .normal)
        widthAnchorCollection[index].isActive = false
        widthAnchorCollection[index].constant = iconHeingh
        widthAnchorCollection[index].isActive = true
        UIView.animate(withDuration: 0.4, delay: 0.1, options: .curveEaseOut, animations: {
            self.layoutIfNeeded()
            self.tabBarItems[index].backgroundColor = .white
        }, completion: nil)
    }
    
}
