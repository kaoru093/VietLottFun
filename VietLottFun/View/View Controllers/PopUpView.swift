//
//  PopUpViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/16/20.
//

import Foundation
import UIKit

class PopUpView: UIView {
    var topFive: [Top5]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    private let midView: UIView = {
       let view = UIView()
        return view
    }()
    
    let label : UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "Helvetica-Bold", size: 26)
        label.text = "Top 5 Numbers Appeared"
        label.textColor = .white
        return label
    }()
    
    lazy var tableView: UITableView = {
        let table = UITableView()
        table.backgroundColor = K.Color().pinkOrange
        table.separatorColor = .white
        return table
    }()
    
    private let doneButton: MyButton = {
       let button = MyButton()
        button.setTitle("Done", for: .normal)
        button.backgroundColor = .none
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.gray.withAlphaComponent(0.4)
        self.frame = UIScreen.main.bounds
        setupMid()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupMid() {
        addSubview(midView)
        midView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        midView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        midView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        midView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        midView.layer.cornerRadius = 20
        midView.clipsToBounds = true
        midView.translatesAutoresizingMaskIntoConstraints = false
        midView.backgroundColor = K.Color().pinkOrange

        midView.addSubview(label)
        label.topAnchor.constraint(equalTo: midView.topAnchor, constant: 5).isActive = true
        label.centerXAnchor.constraint(equalTo: midView.centerXAnchor).isActive = true
        label.widthAnchor.constraint(lessThanOrEqualTo: midView.widthAnchor).isActive = true
        label.heightAnchor.constraint(equalTo: midView.heightAnchor, multiplier: 0.15).isActive = true
        label.translatesAutoresizingMaskIntoConstraints = false
        setupTable()
        setupDoneButton()
    }
    
    func setupTable() {
        midView.addSubview(tableView)
        tableView.centerXAnchor.constraint(equalTo: midView.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: midView.centerYAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: midView.heightAnchor, multiplier: 0.7).isActive = true
        tableView.widthAnchor.constraint(equalTo: midView.widthAnchor, multiplier: 0.9).isActive = true
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PopUpCell.self, forCellReuseIdentifier: "popUp")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func setupDoneButton() {
        let bot : UIView = {
            let view = UIView()
            return view
        }()
        midView.addSubview(bot)
        bot.centerXAnchor.constraint(equalTo: midView.centerXAnchor).isActive = true
        bot.topAnchor.constraint(equalTo: tableView.bottomAnchor).isActive = true
        bot.bottomAnchor.constraint(equalTo: midView.bottomAnchor).isActive = true
        bot.widthAnchor.constraint(equalTo: midView.widthAnchor, multiplier: 0.7).isActive = true
        bot.translatesAutoresizingMaskIntoConstraints = false
        bot.addSubview(doneButton)
        doneButton.centerXAnchor.constraint(equalTo: bot.centerXAnchor).isActive = true
        doneButton.centerYAnchor.constraint(equalTo: bot.centerYAnchor).isActive = true
        doneButton.heightAnchor.constraint(equalTo: bot.heightAnchor, multiplier: 0.7).isActive = true
        doneButton.widthAnchor.constraint(equalTo: bot.widthAnchor, multiplier: 0.5).isActive = true
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
    }
    
    @objc func doneButtonPressed(_ sender: MyButton!) {
        sender.pulsate()
        self.removeFromSuperview()
    }
}

extension PopUpView : UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height/5
    }
}

extension PopUpView : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topFive?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "popUp", for: indexPath) as? PopUpCell else {fatalError("\(Error.self)")}
        cell.leftLabel.text = String(topFive![indexPath.row].number)
        cell.rightLabel.text = String(topFive![indexPath.row].frequency)
        return cell
    }
}

class PopUpCell : UITableViewCell {
    let leftLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 24)
        label.textColor = .white
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    let rightLabel : UILabel = {
       let label = UILabel()
        label.font = UIFont(name: "Helvetica-Light", size: 24)
        label.textColor = .white
        label.contentMode = .center
        label.textAlignment = .center
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [leftLabel,rightLabel])
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = K.Color().pinkOrange
        addSubview(stackView)
        stackView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stackView.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
