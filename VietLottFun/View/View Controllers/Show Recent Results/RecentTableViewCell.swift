//
//  RecentTableViewCell.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/22/20.
//

import Foundation
import UIKit

class RecentTableViewCell: TableViewCell {
    
    var result: RecentResults? = nil {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(style: TableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func registerCollectionView() {
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
}

extension RecentTableViewCell : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return result?.result.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellID", for: indexPath) as? CollectionViewCell else {fatalError("cannot cast collectionViewCell inside tableViewCell")}
        
        cell.number.textColor = K.Color().pinkOrange
        cell.number.layer.borderColor = K.Color().pinkOrange.cgColor
        cell.number.layer.borderWidth = 1
        cell.number.font = UIFont(name: "Helvetica", size: 10)
        
        
        guard let result = result, result.result.count > indexPath.row else {
            cell.number.text = ""
            return cell
            
        }
        
        
        cell.number.text = "\(result.result[indexPath.row])"
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let count = result?.result.count {
            if count > 8 {
                return CGSize(width: 33, height: 33)
            } else if count == 8 {
                return CGSize(width: 40, height: 40)
            }
        }
        return CGSize(width: 42, height: 42)
    }
}

extension RecentTableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
