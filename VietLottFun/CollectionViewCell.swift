//
//  CollectionViewCell.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/25/20.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    let number : UILabel = {
        let label = UILabel()
        label.backgroundColor = UIColor.white
        label.font = UIFont(name: "Helvetica-Bold", size: 30)
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        label.contentMode = .center
        label.textAlignment = .center
        label.textColor = K.Color().pinkOrange
        label.sizeToFit()
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        addSubview(number)
        number.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        number.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        number.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7).isActive = true
        number.widthAnchor.constraint(equalTo: number.heightAnchor).isActive = true
        number.layer.cornerRadius = frame.size.height*0.7/2
    }
    
}
