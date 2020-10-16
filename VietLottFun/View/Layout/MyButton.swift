//
//  MyButton.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/29/20.
//

import Foundation
import UIKit

class MyButton : UIButton {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private var shadowLayer: CAShapeLayer!
    
    private func setup() {
        self.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.setTitleColor(#colorLiteral(red: 0.9960784314, green: 0.4431372549, blue: 0.4431372549, alpha: 1), for: .normal)
        self.titleLabel?.font = UIFont(name: "Helvetica-Bold", size: 17)
//        if self.state == .highlighted {
//            self.shadowLayer.shadowColor = .none
//        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setNeedsUpdateConstraints()
//        self.layer.cornerRadius = self.frame.height/5
//        self.clipsToBounds = true
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 7).cgPath
            shadowLayer.fillColor = UIColor.white.cgColor
            shadowLayer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1).cgColor
            shadowLayer.shadowPath = shadowLayer.path
            shadowLayer.shadowOffset = CGSize(width: 2.0, height: 2.0)
            shadowLayer.shadowOpacity = 0.8
            shadowLayer.shadowRadius = 2
            if state != .selected {
                layer.insertSublayer(shadowLayer, at: 0)
            }
            //layer.insertSublayer(shadowLayer, below: nil) // also works
            shadowLayer.setNeedsLayout()
        }
    }
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.25
        pulse.fromValue = 0.93
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 0.2
        pulse.initialVelocity = 0.2
        pulse.damping = 0.2
        layer.add(pulse, forKey: nil)
    }
    
    func flash() {
        let flash = CABasicAnimation(keyPath: "opacity")
        flash.duration = 0.3
        flash.fromValue = 1
        flash.toValue = 0.1
        flash.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        flash.autoreverses = true
        flash.repeatCount = 2
        layer.add(flash, forKey: nil)
    }
}
