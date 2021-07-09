//
//  CategoryEntity+CoreDataProperties.swift
//  DB
//
//  Created by GGsrvg on 09.07.2021.
//
//

import Foundation
import CoreData


extension CategoryEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CategoryEntity> {
        return NSFetchRequest<CategoryEntity>(entityName: "CategoryEntity")
    }

    @NSManaged public var colorHEX: String?
    @NSManaged public var spentFunds: NSDecimalNumber?
    @NSManaged public var name: String?
    @NSManaged public var fundsLimit: NSDecimalNumber?
    @NSManaged public var periodType: String?
    @NSManaged public var consumptions: NSSet?

}

// MARK: Generated accessors for consumptions
extension CategoryEntity {

    @objc(addConsumptionsObject:)
    @NSManaged public func addToConsumptions(_ value: ConsumptionEntity)

    @objc(removeConsumptionsObject:)
    @NSManaged public func removeFromConsumptions(_ value: ConsumptionEntity)

    @objc(addConsumptions:)
    @NSManaged public func addToConsumptions(_ values: NSSet)

    @objc(removeConsumptions:)
    @NSManaged public func removeFromConsumptions(_ values: NSSet)

}

extension CategoryEntity : Identifiable {

}
