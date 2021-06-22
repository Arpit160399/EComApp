//
//  PageSegmentView.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit

class PageSegementView: UIView {
    private var headerCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    private var pageCollection: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collection = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collection
    }()
    
    lazy var headerdataSource = DataSourceCollectionView<PageHeadercell, Category>(collection: headerCollection, cellSize: { index in
        let cellwidth = self.headerCollection.frame.width / 3
        let newWidth = self.getHeaderWidth(index: index, cellwidth: cellwidth)
        return .init(width: newWidth + 20, height: 30)
    }, cellData: [])
    
    lazy var pageDataSource = DataSourceCollectionView<PageViewCell, Category>(collection: pageCollection, cellSize: { _ in
        let height = self.pageCollection.frame.height
        return .init(width: self.frame.width, height: height)
    }, cellData: [])
    let activity = UIActivityIndicatorView()
    private var currentIndex: Int = 0
    private var selectionAction = true
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        headerCollection.dataSource = headerdataSource
        headerCollection.delegate = headerdataSource
        pageDataSource.spacing = 0
        pageCollection.dataSource = pageDataSource
        pageCollection.delegate = pageDataSource
        addPageHeaderCollectionView()
        addPageCollectionView()
        addActivityView(activityLoader: activity)
        getCategory()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func addPageHeaderCollectionView() {
        headerCollection.backgroundColor = .primaryBackgroundColor
        headerCollection.contentInset = .init(top: 0, left: 15, bottom: 0, right: 10)
        headerCollection.showsHorizontalScrollIndicator = false
        addSubview(headerCollection)
        headerCollection
            .addTopAnchor(equal: topAnchor)
            .addLeftAnchor(equal: leftAnchor)
            .addRightAnchor(equal: rightAnchor)
            .addHeightAnchor(constant: 60)
        headerdataSource.cellSeletedAction = { index in
            self.handelHeaderSelection(index: index)
        }
    }

    fileprivate func addPageCollectionView() {
        pageCollection.backgroundColor = .primaryBackgroundColor
        pageCollection.isPagingEnabled = true
        pageCollection.showsHorizontalScrollIndicator = false
        addSubview(pageCollection)
        pageCollection
            .addTopAnchor(equal: headerCollection.bottomAnchor)
            .addLeftAnchor(equal: leftAnchor)
            .addRightAnchor(equal: rightAnchor)
            .addBottomAnchor(equal: bottomAnchor)
        pageDataSource.scrollingAction = { scrollview in
            self.pageScrollingIndex(scrollView: scrollview)
        }
    }
    
    fileprivate func getHeaderWidth(index: IndexPath, cellwidth: CGFloat) -> CGFloat {
        return headerdataSource.data[index.item].name.textSizeReqired(givensize: .init(width: cellwidth, height: 20), font: UIFont.systemFont(ofSize: 14, weight: .semibold)).width
    }
    
    fileprivate func pageScrollingIndex(scrollView: UIScrollView) {
        let index = Int(scrollView.contentOffset.x / pageCollection.frame.width)
        if currentIndex != index {
            currentIndex = index
            print(index)
            let indexpath = IndexPath(item: index, section: 0)
            headerCollection.scrollToItem(at: indexpath, at: .centeredHorizontally, animated: true)
            headerCollection.selectItem(at: indexpath, animated: true, scrollPosition: .centeredHorizontally)
        }
    }

    fileprivate func handelHeaderSelection(index: IndexPath) {
        pageCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
    }
    
    fileprivate func getCategory() {
        DataSourceProvider.stander.getCategory { [weak self] categoriesList, error in
            guard let self = self else {return}
            if error != nil {
                return
            }
            guard let categoriesList = categoriesList else {
                return
            }
            self.pageDataSource.data = categoriesList
            self.headerdataSource.data = categoriesList
            self.headerCollection.selectItem(at: IndexPath(item: 0, section: 0), animated: true, scrollPosition: .centeredVertically)
            self.removeAcivityView(activityLoader: self.activity)
        }
    }
}
