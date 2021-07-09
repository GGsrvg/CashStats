//
//  CategoryEntity+CoreDataClass.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//
//

import Foundation
import CoreData
import DTO

public protocol ConvertableEntity where Self : NSManagedObject {
    associatedtype DTObject
    
    func set(by model: DTObject)
    func convertToDTO() -> DTObject
}

@objc(CategoryEntity)
public class CategoryEntity: NSManagedObject {
    
}

extension CategoryEntity: ConvertableEntity {
    public typealias DTObject = DTO.Category
    
    public func set(by model: DTO.Category) {
        self.colorHEX = model.colorHEX
        self.name = model.name
        self.fundsLimit = NSDecimalNumber(decimal: model.fundsLimit)
        self.spentFunds = NSDecimalNumber(decimal: model.spentFunds)
        self.periodType = model.periodType.rawValue
    }
    
    public func convertToDTO() -> DTO.Category {
        return .init(
            name: self.name ?? "ERROR NAME",
            colorHEX: self.colorHEX ?? "#ffffff",
            spentFunds: self.spentFunds?.decimalValue ?? 0,
            fundsLimit: self.fundsLimit?.decimalValue ?? 0,
            periodType: DTO.Category.CategoryType(rawValue: self.periodType ?? "") ?? .month
        )
    }
}
