//
//  CollectionviewData.swift
//  Ecom
//
//  Created by Arpit Singh on 21/06/21.
//

import UIKit

class DataSourceCollectionView <T: TempleteCollectioViewCell,U : Codable>:NSObject,UICollectionViewDelegateFlowLayout,UICollectionViewDataSource {
    var data: [U] {
        didSet {
            collectionView.reloadData()
        }
    }
    var cellSeletedAction : ((IndexPath) -> Void)?
    var scrollingAction: ((UIScrollView) -> Void)?
    var spacing: CGFloat = 6
    var insets = UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    var size : (_ index:IndexPath) -> CGSize
    var addSupllmentaryView: ((_ kind: String,_ index: IndexPath) -> UICollectionReusableView)?
    var supplementFooterSizehandler: ((_ section: Int) -> CGSize)?
    private var collectionView: UICollectionView
    init(collection: UICollectionView,cellSize: @escaping (_ index:IndexPath) -> CGSize = { index in  return .init(width: 200, height: 200) },cellData: [U]) {
        collectionView = collection
        size = cellSize
        data = cellData
        super.init()
        collection.register(T.self, forCellWithReuseIdentifier: T.cellIdentiffer)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: T.cellIdentiffer, for: indexPath) as? TempleteCollectioViewCell else {
        return UICollectionViewCell()
       }
        let value = data[indexPath.item]
        cell.configCellWith(value: value)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        cellSeletedAction?(indexPath)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return size(indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return spacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return insets
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollingAction?(scrollView)
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        guard let view = addSupllmentaryView?(kind,indexPath) else {
            return UICollectionReusableView()
        }
       return view
    }
       
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        return supplementFooterSizehandler?(section) ?? .zero
    }
    
}
