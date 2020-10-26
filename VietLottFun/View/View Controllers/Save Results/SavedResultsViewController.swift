//
//  SavedResultsViewController.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/22/20.
//

import Foundation
import UIKit
import CoreData


class SavedResultsViewController: TableLoadOutViewController {
    
    var percentageArray = [String]()
    
//    var numbers: 
    var type: TypeK? {
        didSet {
            topLabel.text = "Your saved results of \(type!.name)"
            tableView.reloadData()
            vietLottResult.loadNumber(type!)
            vietLottResult.fetchResult(type!.modeApiNum)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func statsButtonPressed(_ sender: MyButton) {
        sender.pulsate()
        percentageArray.removeAll()
        vietLottResult.savedNumbers.forEach { (number) in
            self.percentageArray.append(vietLottResult.percentage(array1: number.resultInt!, array2: vietLottResult.resultModel[0].result))
        }
        DispatchQueue.main.async {
            print(self.percentageArray)
            self.tableView.reloadData()
        }
    }

    override func registerTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(SavedTableViewCell.self, forCellReuseIdentifier: "saveCell")
    }
    
    
}

extension SavedResultsViewController : UITableViewDelegate {
    
}

extension SavedResultsViewController : UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vietLottResult.savedNumbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "saveCell", for: indexPath) as? SavedTableViewCell else {fatalError("Cannot cast Saved Table View Cell")}
        if let date = vietLottResult.savedNumbers[indexPath.row].date {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd/MM/yy"
            let dateString = dateFormatter.string(from: date)
            cell.leftLabel.text = dateString
            cell.number = vietLottResult.savedNumbers[indexPath.row]
            if percentageArray.count != 0 {
                cell.rightLabel.text = percentageArray[indexPath.row]
            }
        }
        return cell
    }
    
    
}


