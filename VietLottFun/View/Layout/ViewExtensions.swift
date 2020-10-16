//
//  ViewExtensions.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/16/20.
//

import Foundation
import UIKit

extension UIView {
    func anchor(top: NSLayoutYAxisAnchor?, leading: NSLayoutXAxisAnchor?, trailing: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, padding: UIEdgeInsets = .zero, size: CGSize = .zero) {
        translatesAutoresizingMaskIntoConstraints = false
        if let top = top, let trailing = trailing, let leading = leading, let bottom = bottom {
            topAnchor.constraint(equalTo: top, constant: padding.top).isActive = true
            bottomAnchor.constraint(equalTo: bottom, constant: -padding.bottom).isActive = true
            leadingAnchor.constraint(equalTo: leading, constant: padding.left).isActive = true
            trailingAnchor.constraint(equalTo: trailing, constant: -padding.right).isActive = true
        }
        
        if size.width != 0 {
            widthAnchor.constraint(equalToConstant: size.width).isActive = true
        }
        if size.height != 0 {
            heightAnchor.constraint(equalToConstant: size.height).isActive = true
        }
        
    }
}
