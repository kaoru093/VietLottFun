//
//  SavedTableViewCell.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/6/20.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
    var result: Results? = nil {
        didSet {
            collectionView.reloadData()
        }
    }
    
    let leftLabel: UILabel = {
        let label = UILabel()
        //        label.text = "Today"
        label.contentMode = .scaleAspectFit
        label.font = UIFont(name: "Helvetica", size: 13)
        label.textAlignment = .center
        label.textColor = K.Color().pinkOrange
        label.setContentHuggingPriority(.sceneSizeStayPut, for: .vertical)
        return label
    }()
    
    let midView: UIView = {
        return UIView()
    }()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.backgroundColor = .clear
        collectionview.setContentHuggingPriority(.init(rawValue: 1000), for: .vertical)
        return collectionview
    }()
    
    let rightLabel: UILabel = {
        let label = UILabel()
        //        label.text = "0%"
        label.contentMode = .center
        label.font = UIFont(name: "Helvetica", size: 17)
        label.textAlignment = .center
        label.textColor = K.Color().pinkOrange
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCell() {
        addSubview(leftLabel)
        addSubview(midView)
        addSubview(rightLabel)
        setupLeftLabel()
        setupRightLabel()
        setupMidView()
        setupUI()
    }
    
    func setupLeftLabel() {
        leftLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        leftLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        leftLabel.frame.size.height = 25
        leftLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.15).isActive = true
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        
    }
    
    func setupRightLabel() {
        
        rightLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        rightLabel.frame.size.height = 25
        rightLabel.leadingAnchor.constraint(equalTo: midView.trailingAnchor).isActive = true
        rightLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        rightLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setupMidView() {
        midView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        midView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        midView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        midView.leadingAnchor.constraint(equalTo: leftLabel.trailingAnchor).isActive = true
        midView.translatesAutoresizingMaskIntoConstraints = false
        midView.contentMode = .center
        midView.addSubview(collectionView)
        setupCollectionView()
    }
    
    func setupCollectionView() {
        collectionView.topAnchor.constraint(equalTo: midView.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: midView.bottomAnchor).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: midView.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: midView.trailingAnchor).isActive = true
        collectionView.frame = midView.frame
        collectionView.register(CollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.reloadData()
    }
    
    func setDelegate(forRow row: Int) {
        collectionView.tag = row
    }
    
    func setupUI() {
        
    }
}

extension TableViewCell : UICollectionViewDataSource {
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

extension TableViewCell : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
}
