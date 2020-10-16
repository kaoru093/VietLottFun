//
//  VietLottResult.swift
//  VietLottFun
//
//  Created by kaorupuka on 10/5/20.
//

import Foundation
import SwiftyJSON

class VietLottResult {
    let urlString = "https://hoanglanngocthaowedding.com/api/vietlott/"
    var type: TypeK?
    var delegate: VietLottResultDelegate?
    var resultModel : [Results] = []
    var allResult : [Int] = []
    var topFive: [Top5] = []
    
    func fetchResult(_ mode: Int) {
        if let url = URL(string: urlString+String(mode)) {
            let session = URLSession(configuration: .default)
            let tasks = session.dataTask(with: url) { (data, response, err) in
                if err != nil {
                    print(err?.localizedDescription as Any)
                    self.delegate?.didFailWithError()
                } else {
                    if let safeData = data {
                        if mode != 5 {
                            let decoder = JSONDecoder()
                            do {
                                let resultModel = try decoder.decode([Results].self, from: safeData)
                                self.resultModel = resultModel
                                self.delegate?.didFetchResult(resultModel)
                                self.getTotalResultArray(self.resultModel)
                            }
                            catch {
                                print(error)
                            }
                        }
                        else {
                            var resultModel : [Results] = []
                            var result = Results(date: 0, result: [])
                            for i in 0...JSON(safeData).count {
                                result.date = JSON(safeData)[i]["date"].intValue
                                let array = JSON(safeData)[i]["result"].arrayValue
                                var numberArray : [Int] = []
                                for string in array {
                                    let number = self.convertStringToInt(string.stringValue)
                                    numberArray.append(number)
                                }
                                result.result = numberArray
                                resultModel.append(result)
                            }
                            resultModel.removeLast()
                            self.resultModel = resultModel
                            self.delegate?.didFetchResult(resultModel)
                            self.getTotalResultArray(self.resultModel)
                        }
                    }
                    
                }
            }
            tasks.resume()
        }
    }
    
    func convertStringToInt(_ string: String) -> Int {
        var stringValue = string
        while stringValue.contains("X") {
            stringValue.removeFirst()
        }
        if let intValue = Int(stringValue) {
            return intValue
        } else {
            return 0
        }
        
    }
    
    func unixDate(_ date: Int) -> String {
        let dateString = Date(timeIntervalSince1970: Double(date))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "dd/MM/yy" //Specify your format that you want
        let localDate = dateFormatter.string(from: dateString)
        return localDate
    }
    
    func getTotalResultArray(_ resultModel: [Results]) {
        var array : [Int] = []
        for results in resultModel {
            for i in results.result {
                array.append(i)
            }
        }
        self.allResult = array
    }
    
    func analyzePrizeFrequency(_ array: [Int]) {
        var counts = [Int: Int]()
        var topFive = [Top5]()
        array.forEach { counts[$0] = (counts[$0] ?? 0) + 1 }
        print(counts)
        let sorted = counts.sorted(by: {$0.1 > $1.1})
        for i in 0...4 {
            topFive.append(Top5(number: sorted[i].key, frequency: sorted[i].value))
        }
        self.topFive = topFive
        print(self.topFive)
    }
}




protocol VietLottResultDelegate {
    func didFetchResult(_ vietLottResults: [Results])
    func didFailWithError()
}
