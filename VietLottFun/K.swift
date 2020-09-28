//
//  K.swift
//  VietLottFun
//
//  Created by kaorupuka on 9/19/20.
//

import Foundation
import UIKit

enum TypeK: Int {
    case jackPot = 0, mega, max3D, max4D, keno
    
    //Vi du
    var name: String {
        switch self {
        case .jackPot: return "JackPot 6/55"
        case .mega: return "Mega 6/45"
        case .max3D: return "Max 3D / Max 3D+"
        case .max4D: return "Max 4D"
        case .keno: return "Keno"
        }
    }
    
    var definition: String {
        switch self {
        case .jackPot: return "HOW TO PLAY: Choose 06 numbers from 01 to 55 to have a chance to win the JackPot"
        case .mega: return "HOW TO PLAY: Choose 06 numbers from 01 to 45 to have a chance to win the Mega game"
        case .max3D: return "HOW TO PLAY: Choose ONE 3-digit number from 000 to 999 to have a chance to win Max 3D or choose TWO 3-digit numbers to win a lot more from Max 3D Plus"
        case .max4D: return "HOW TO PLAY: Choose ONE 4-digit number from 0000 to 9999 to have a chance to win the Max 4D"
        case .keno: return "HOW TO PLAY: Choose up to TEN numbers from 01 to 80 to have a chance to win a big prize"
        }
    }
    
    var genNum: Int {
        switch self {
        case .jackPot, .mega : return 6
        case .max3D, .max4D : return 1
        case .keno: return 10
        }
    }
    
    var startNum: Int {
        switch self {
        case .jackPot, .mega, .keno: return 1
        case .max3D, .max4D: return 0
        }
    }
    
    var endNum: Int {
        switch self {
        case .jackPot: return 55
        case .mega: return 45
        case .keno: return 80
        case .max3D: return 999
        case .max4D: return 9999
        }
    }
}


struct K {
    struct Color {
        let pinkOrange = UIColor(red: 254/255, green: 113/255, blue: 113/255, alpha: 1.0)
    }
    
    var modeArray: [TypeK] = [.jackPot, .mega, .max3D, .max4D, .keno]

    /*
    struct Mode {
        let name: String
        let definition: String
        var genNum: Int
        var startNum: Int
        var endNum: Int
        let type: TypeK
    }
    var modeArray =
        [Mode(name: "JackPot 6/55", definition: "HOW TO PLAY: Choose 06 numbers from 01 to 55 to have a chance to win the JackPot", genNum: 6, startNum: 1, endNum: 55, type: .jackPot),
         Mode(name: "Mega 6/45", definition: "HOW TO PLAY: Choose 06 numbers from 01 to 45 to have a chance to win the Mega game", genNum: 6, startNum: 1, endNum: 45, type: .mega),
         Mode(name: "Max 3D / Max 3D+", definition: "HOW TO PLAY: Choose ONE 3-digit number from 000 to 999 to have a chance to win Max 3D or choose TWO 3-digit numbers to win a lot more from Max 3D Plus", genNum: 6, startNum: 0, endNum: 999, type: .max3D),
         Mode(name: "Max 4D", definition: "HOW TO PLAY: Choose ONE 4-digit number from 0000 to 9999 to have a chance to win the Max 4D", genNum: 6, startNum: 0, endNum: 999, type: .max4D),
         Mode(name: "Keno", definition: "HOW TO PLAY: Choose up to TEN numbers from 01 to 80 to have a chance to win a big prize", genNum: 10, startNum: 1, endNum: 80, type: .keno)
    ]
 */
}
