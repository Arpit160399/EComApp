//
//  PageView.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class PageViewCell: UICollectionViewCell,TempleteCollectioViewCell {
    static var cellIdentiffer: String = "PageViewCell"
    var loaderViewId = "LoaderViewID"
    private let productListCollectionView: UICollectionView = {
        let flowlayout = UICollectionViewFlowLayout()
        flowlayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowlayout)
        return collectionView
    }()
    let acivityView = UIActivityIndicatorView()
    var categoryID: String = "0"
    var isloading: Bool = false
    lazy var dataSource = DataSourceCollectionView<ProductCell,Product>(collection: productListCollectionView, cellSize: { index in
        let width = (self.productListCollectionView.frame.width - 2) / 2
        let height = self.calculateHeight(index: index.item, width: width)
        return .init(width: width, height: height)
    }, cellData: [])
    fileprivate func addCollectionView() {
        contentView.addSubview(productListCollectionView)
        productListCollectionView.contentInset = .init(top: 0, left: 0, bottom: 50, right: 0)
        productListCollectionView.backgroundColor = .primaryBackgroundColor
        productListCollectionView.addTopAnchor(equal: contentView.topAnchor)
            .addBottomAnchor(equal: contentView.bottomAnchor)
            .addLeftAnchor(equal:  contentView.leftAnchor)
            .addRightAnchor(equal: contentView.rightAnchor)
        productListCollectionView.dataSource = dataSource
        productListCollectionView.delegate = dataSource
        productListCollectionView.register(loaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: loaderViewId)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addCollectionView()
        addLoaderview()
        dataSource.spacing = 0
        contentView.addActivityView(activityLoader: acivityView)
    }
    


    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func getproducts(_ id: String,page: Int) {
        DataSourceProvider.stander.getProductList(ofcategory: id,page: page) { products, error in
            if error != nil {
                return
            }
            self.loaderingView(show: false)
            self.isloading = false
            guard let productlist = products else {return}
            self.dataSource.data.append(contentsOf: productlist)
            self.contentView.removeAcivityView(activityLoader: self.acivityView)
        }
    }
    
func configCellWith(value: Any) {
        if let category = value as?  Category {
            categoryID = category.id
            getproducts(category.id,page: 0)
           UserCart.shared.valueUpdated = { [weak self] in
            self?.productListCollectionView.reloadData()
         }
       }
    }
    
    private func addLoaderview() {
        dataSource.scrollingAction = collectionViewDidScroll
        dataSource.addSupllmentaryView = { kind,index  in
            switch kind {
            case UICollectionView.elementKindSectionFooter:
                guard let view = self.productListCollectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: self.loaderViewId, for: index) as? loaderView else {
                    return UICollectionReusableView()
                }
              view.activeload.startAnimating()
              return view
            default : return UICollectionReusableView()
            }
        }
    }
    
    private func loaderingView(show: Bool) {
        dataSource.supplementFooterSizehandler = { section in
            return show ? .zero : CGSize(width: self.frame.width, height: 50)
        }
    }
    
    private func calculateHeight(index: Int,width: CGFloat) -> CGFloat {
        let product = dataSource.data[index]
        let size = CGSize(width: width - 30, height: .infinity)
        let title = product.name.textSizeReqired(givensize: .init(width: width - 70, height: .infinity), font: .systemFont(ofSize: 15, weight: .bold)).height
        let subtile = product.subtext.textSizeReqired(givensize: size, font: .systemFont(ofSize: 11, weight: .medium)).height
        let price = "Rs \(product.price) / \(product.uints)".textSizeReqired(givensize: size, font: .systemFont(ofSize: 11, weight: .bold)).height
      return 220 + title + subtile + price
    }
    
    private func collectionViewDidScroll(scrollView: UIScrollView) {
        let offeset = scrollView.contentOffset.y
        let index = Int( offeset / productListCollectionView.frame.height )
        if offeset > productListCollectionView.contentSize.height - scrollView.frame.height  && !isloading {
            loaderingView(show: true)
            getproducts(categoryID, page: index)
            isloading = true
        }
    }
    
}

