//
//  ViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/19/20.
//

import UIKit

class ModeViewController: UIViewController, UINavigationControllerDelegate {
    private let welcomeText: UILabel = {
        let label = UILabel()
        label.text = "Welcome to Viet Lottery Fun Number Generator!"
        label.font = UIFont(name: "Helvetica-Bold", size: 24)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        return label
    }()
    
    private let choosingText: UILabel = {
        let label = UILabel()
        label.text = "Choose your mode:"
        label.font = UIFont(name: "Helvetica-Italic", size: 14)
        label.textColor = UIColor.white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.backgroundColor = .clear
        return label
    }()
    
    private let topStack : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
        return stackView
    }()
    
    private let bottomStack : UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillProportionally
        stackView.axis = .vertical
        return stackView
    }()
    
    private let buttonArray : [MyButton] = {
        var array = [MyButton]()
        for (i, mode) in K().modeArray.enumerated() {
            let button = MyButton()
            button.setTitle(mode.name, for: .normal)
            button.tag = i
            array.append(button)
            button.addTarget(self, action: #selector(modeButtonPressed(_:)), for: .touchUpInside)
        }
        return array
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false
        title = "Viet Lottery Fun"
        view.backgroundColor = K.Color().pinkOrange
        view.addSubview(topStack)
        view.addSubview(bottomStack)
        navBarSetup()
        setupTopStack()
        setupBottomStack()
    }
    
    private func navBarSetup() {
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = K.Color().pinkOrange
            navBar.tintColor = UIColor.white
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 16)!]
        }
    }
    
    private func setupTopStack() {
        topStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        topStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        topStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        topStack.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.25).isActive = true
        
        topStack.translatesAutoresizingMaskIntoConstraints = false
        topStack.addArrangedSubview(welcomeText)
        topStack.addArrangedSubview(choosingText)
    }
    
    private func setupBottomStack() {
        bottomStack.translatesAutoresizingMaskIntoConstraints = false
        bottomStack.topAnchor.constraint(equalTo: topStack.bottomAnchor, constant: 0).isActive = true
        bottomStack.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
        bottomStack.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        bottomStack.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        for button in buttonArray {
            let view = UIView()
            bottomStack.addArrangedSubview(view)
            view.addSubview(button)
            button.translatesAutoresizingMaskIntoConstraints = false
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            button.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
            button.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5).isActive = true
            button.clipsToBounds = false
            button.layer.cornerRadius = 15
        }
        bottomStack.distribution = .fillEqually
    }
    
    @objc func modeButtonPressed(_ sender: MyButton!) {
        print(sender.titleLabel?.text! as Any)
        sender.flash()
        
        guard sender.tag < K().modeArray.count else { return}
        
        switch K().modeArray[sender.tag] {
        case .keno:
            let kenoVC = KenoViewController()
            kenoVC.type = K().modeArray[sender.tag]
            navigationController?.pushViewController(kenoVC, animated: true)
            
        default:
            let playVC = PlayViewController()
            playVC.type = K().modeArray[sender.tag]
            navigationController?.pushViewController(playVC, animated: true)
        }
        
    }
    
}

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
        if self.state == .highlighted {
            self.shadowLayer.shadowColor = .none
        }
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if shadowLayer == nil {
            shadowLayer = CAShapeLayer()
            shadowLayer.path = UIBezierPath(roundedRect: bounds, cornerRadius: 12).cgPath
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
        }
    }
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.4
        pulse.fromValue = 0.8
        pulse.toValue = 1.0
        pulse.autoreverses = true
        pulse.repeatCount = 0.5
        pulse.initialVelocity = 0.3
        pulse.damping = 0.4
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

