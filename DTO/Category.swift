//
//  Category.swift
//  DTO
//
//  Created by GGsrvg on 02.07.2021.
//

import Foundation

public struct Category: Codable {
    public var id: Int64?
    public let date: Date
    public var name: String
    public var colorHEX: Int
    /// средств потраченных в текущем периоде
    public var spentFunds: Double
    /// лимит средств на определенный период
    public var fundsLimit: Double
    public var periodTypeInt: Int
    public var periodType: CategoryType? { get {
        return CategoryType(rawValue: self.periodTypeInt)
    } }
    
    
    public init(
        date: Date,
        name: String,
        colorHEX: Int,
        spentFunds: Double,
        fundsLimit: Double,
        periodTypeInt: Int
    ) {
        self.date = date
        self.name = name
        self.colorHEX = colorHEX
        self.spentFunds = spentFunds
        self.fundsLimit = fundsLimit
        self.periodTypeInt = periodTypeInt
    }
    
}

extension Category: Hashable {
//    public static func == (lhs: Category, rhs: Category) -> Bool {
//        lhs === rhs
//    }
//    
//    public func hash(into hasher: inout Hasher) {
//        
//    }
}

public extension Category {
    enum CategoryType: Int {
        case month = 0
        case year = 1
    }
}
