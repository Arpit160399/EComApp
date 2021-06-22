//
//  ViewController.swift
//  Ecom
//
//  Created by Arpit Singh on 19/06/21.
//

import UIKit

class HomeController: UIViewController {
    let pageSectionView = PageSegementView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primaryBackgroundColor
        navigationController?.setPlainNaviagtionBar(title: "Home")
        // Do any additional setup after loading the view.
        DataSourceProvider.stander.config()
        view.addSubview(pageSectionView)
        pageSectionView.addTopAnchor(equal: view.safeAreaLayoutGuide.topAnchor)
            .addLeftAnchor(equal: view.leftAnchor)
            .addRightAnchor(equal: view.rightAnchor)
            .addBottomAnchor(equal: view.safeAreaLayoutGuide.bottomAnchor)
    }
}
