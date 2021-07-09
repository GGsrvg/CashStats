//
//  ConsumptionEntity+CoreDataProperties.swift
//  DB
//
//  Created by GGsrvg on 09.07.2021.
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
    @NSManaged public var categories: NSSet?

}

// MARK: Generated accessors for categories
extension ConsumptionEntity {

    @objc(addCategoriesObject:)
    @NSManaged public func addToCategories(_ value: CategoryEntity)

    @objc(removeCategoriesObject:)
    @NSManaged public func removeFromCategories(_ value: CategoryEntity)

    @objc(addCategories:)
    @NSManaged public func addToCategories(_ values: NSSet)

    @objc(removeCategories:)
    @NSManaged public func removeFromCategories(_ values: NSSet)

}

extension ConsumptionEntity : Identifiable {

}
