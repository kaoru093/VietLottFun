//
//  SavedViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/15/20.
//

import Foundation
import UIKit

class TableLoadOutViewController : UIViewController {
    var vietLottResult = VietLottResult()
    
    private let statsButton : MyButton = {
        let button = MyButton()
        button.setTitle("Show Stats", for: .normal)
        button.backgroundColor = .none
        return button
    }()
    
    private let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    let topLabel : UILabel = {
        let label = UILabel()
        label.text = "Instruction"
        label.textAlignment = .left
        label.font = UIFont(name: "Helvetica", size: 24)
        label.textColor = .white
        return label
    }()
    
    lazy var tableView : UITableView = {
        let tableView = UITableView.init(frame: .zero)
        return tableView
    }()
    
    private let bottomView : UIStackView = {
       let view = UIStackView()
        return view
    }()
    
    override func viewDidLoad() {
        setupLayout()
    }
    
    func setupLayout() {
        view.backgroundColor = K.Color().pinkOrange
        navBarSetup()
        view.addSubview(topView)
        view.addSubview(tableView)
        view.addSubview(bottomView)
        setupTop()
        setupTableView()
        setupBottom()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.updateViewConstraints()
    }
    
    func navBarSetup() {
        if let navBar = navigationController?.navigationBar {
            navBar.barTintColor = K.Color().pinkOrange
            navBar.tintColor = UIColor.white
            title = "VietLott Fun"
            navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white,NSAttributedString.Key.font : UIFont(name: "Helvetica-Bold", size: 16)!]
        }
    }
    
    func setupTop() {
        topView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        topView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        topView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        topView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.15).isActive = true
        topView.translatesAutoresizingMaskIntoConstraints = false
        
        topView.addSubview(topLabel)
        topLabel.centerYAnchor.constraint(equalTo: topView.centerYAnchor).isActive = true
        topLabel.centerXAnchor.constraint(equalTo: topView.centerXAnchor).isActive = true
        topLabel.widthAnchor.constraint(lessThanOrEqualTo: topView.widthAnchor).isActive = true
        topLabel.heightAnchor.constraint(lessThanOrEqualTo: topView.heightAnchor).isActive = true
        topLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    func setupTableView() {
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: topView.bottomAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor, multiplier: 0.7).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.separatorColor = K.Color().pinkOrange.withAlphaComponent(0.5)
        registerTableView()
    }
    
    func registerTableView() {
        tableView.register(TableViewCell.self, forCellReuseIdentifier: "savedCell")
    }
    
    func setupBottom() {
        bottomView.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        bottomView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        bottomView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        bottomView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        bottomView.translatesAutoresizingMaskIntoConstraints = false
        
        
        bottomView.addSubview(statsButton)
        statsButton.centerXAnchor.constraint(equalTo: bottomView.centerXAnchor, constant: 0).isActive = true
        statsButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor, constant: 0).isActive = true
        statsButton.heightAnchor.constraint(equalTo: bottomView.heightAnchor, multiplier: 0.5).isActive = true
        statsButton.widthAnchor.constraint(equalTo: bottomView.widthAnchor, multiplier: 0.5).isActive = true
        statsButton.translatesAutoresizingMaskIntoConstraints = false
        statsButton.addTarget(self, action: #selector(statsButtonPressed(_:)), for: .touchUpInside)
        statsButton.setNeedsUpdateConstraints()
    }
    
    @objc func statsButtonPressed(_ sender: MyButton) {
        sender.pulsate()
    }
}
