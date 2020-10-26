//
//  SavedTableViewCell.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/6/20.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    
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
        label.contentMode = .scaleAspectFit
        label.font = UIFont(name: "Helvetica", size: 13)
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
        midView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.7).isActive = true
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
        registerCollectionView()
    }
    
    func registerCollectionView() {
        
    }
}


