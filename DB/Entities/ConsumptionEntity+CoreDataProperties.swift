//
//  ConsumptionEntity+CoreDataProperties.swift
//  DB
//
//  Created by GGsrvg on 12.07.2021.
//
//

import Foundation
import CoreData


extension ConsumptionEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ConsumptionEntity> {
        return NSFetchRequest<ConsumptionEntity>(entityName: "ConsumptionEntity")
    }

    @NSManaged public var date: Date?
    @NSManaged public var name: String?
    @NSManaged public var price: NSDecimalNumber?
    @NSManaged public var category: CategoryEntity?

}

extension ConsumptionEntity : Identifiable {

}
