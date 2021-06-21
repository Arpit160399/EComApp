//
//  templet Cell.swift
//  Ecom
//
//  Created by Arpit Singh on 20/06/21.
//

import UIKit
protocol TempleteCollectioViewCell: UICollectionViewCell  {
    static var cellIdentiffer: String { get }
    func configCellWith(value: Any)
}
