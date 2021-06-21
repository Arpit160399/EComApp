//
//  TabBar.swift
//  Ecom
//
//  Created by Arpit Singh on 19/06/21.
//

import UIKit
class ExpandingTabBarController : UITabBarController {
     private var tabBarHeight: CGFloat
     private var customTabBar: ExapandingTabBar!
     var tabBarItems = [TabBarItem]()
    
    init(items: [TabBarItem],height:CGFloat = 67) {
        tabBarItems = items
        tabBarHeight = height
        super.init(nibName: nil, bundle: nil)
        loadTabBar()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func loadTabBar(){
            self.setupCustomTabMenu(tabBarItems) { (controller) in
                self.viewControllers = controller
            }
            self.selectedIndex = 0
        }
        
  fileprivate func setupCustomTabMenu(_ menuItems: [TabBarItem], completion: @escaping ([UIViewController]) -> Void) {
            let frame =  CGRect(x: tabBar.frame.origin.x, y: tabBar.frame.origin.y, width: tabBar.frame.width, height: tabBarHeight)
            var controller = [UIViewController]()
            tabBar.isHidden = true
            customTabBar = ExapandingTabBar(menuItems: menuItems,frame: frame)
            customTabBar.makeCurrentTabAction = self.changeTab(tab:)
    //        customTabBar.clipsToBounds = true
            customTabBar.backgroundColor = .white
            view.addSubview(customTabBar)
            customTabBar.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner]
//            customTabBar.layer.shadowOpacity = 0.1
//            customTabBar.layer.shadowRadius = 8
//            customTabBar.layer.shadowOffset = .init(width: 0, height: -2.0)
            customTabBar.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                customTabBar.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
                customTabBar.heightAnchor.constraint(equalToConstant: frame.height),
                customTabBar.leftAnchor.constraint(equalTo: tabBar.leftAnchor),
                customTabBar.rightAnchor.constraint(equalTo: tabBar.rightAnchor),
            ])
            
            menuItems.forEach { (item) in
                controller.append(item.viewController)
            }
            
            self.view.layoutIfNeeded()
            completion(controller)
        }
        
 fileprivate func changeTab(tab : Int){
            self.selectedIndex = tab
        }
}
