//
//  Numbers+CoreDataProperties.swift
//  
//
//  Created by kaorupuka on 10/25/20.
//
//

import Foundation
import CoreData


extension Numbers {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Numbers> {
        return NSFetchRequest<Numbers>(entityName: "Numbers")
    }

    @NSManaged public var date: Date?
    @NSManaged public var resultInt: [Int]?
    @NSManaged public var resultString: [String]?
    @NSManaged public var type: String?

}
