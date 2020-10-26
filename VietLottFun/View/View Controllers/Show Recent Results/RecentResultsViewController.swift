//
//  RecentResultsViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/5/20.
//

import Foundation
import UIKit
//
class RecentResultsTableVC: TableLoadOutViewController {

    var type: TypeK? {
        didSet {
            vietLottResult.fetchResult(type!.modeApiNum)
            topLabel.text = "Most recent results of \(type!.name)"
        }
    }

    override func viewDidLoad() {
        setupLayout()
        vietLottResult.delegate = self
        tableView.reloadData()
    }

    override func statsButtonPressed(_ sender: MyButton) {
        sender.pulsate()
        vietLottResult.analyzePrizeFrequency(vietLottResult.allResult)
        let pop = PopUpView()
        pop.topFive = vietLottResult.topFive
        view.addSubview(pop)
    }

    override func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(RecentTableViewCell.self, forCellReuseIdentifier: "tableCell")
    }
    
    func updateUI() {
        guard vietLottResult.resultModel.count > 0 else {return}
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
}


extension RecentResultsTableVC: UITableViewDataSource {
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vietLottResult.resultModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "tableCell", for: indexPath) as? RecentTableViewCell else {fatalError("cannot cast TableViewCell")}
        configRecentCell(cell, indexPath: indexPath)
        return cell
    }
    
    func configRecentCell(_ cell: RecentTableViewCell, indexPath: IndexPath) {
        
        let results = vietLottResult.resultModel[indexPath.row]
        let date = results.date
        cell.leftLabel.text = vietLottResult.unixDate(date)
        cell.result = results
        
    }
}

extension RecentResultsTableVC: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch type?.modeApiNum {
        case 1, 2, 5:
            return 44
        default:
            return 70
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}


extension RecentResultsTableVC : VietLottResultDelegate {
    func didFetchResult(_ vietLottResults: [RecentResults]) {
        print("success")
        updateUI()
    }

    func didFailWithError() {
        print("Error getting API info")
    }
}
