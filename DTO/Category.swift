//
//  Category.swift
//  DTO
//
//  Created by GGsrvg on 02.07.2021.
//

import Foundation

public struct Category {
    public var name: String
    public var colorHEX: Int
    /// средств потраченных в текущем периоде
    public var spentFunds: Decimal
    /// лимит средств на определенный период
    public var fundsLimit: Decimal
    public var periodType: CategoryType
    //    public var consumptions: NSSet?
    
    
    public init(
        name: String,
        colorHEX: Int,
        spentFunds: Decimal,
        fundsLimit: Decimal,
        periodType: CategoryType
    ) {
        self.name = name
        self.colorHEX = colorHEX
        self.spentFunds = spentFunds
        self.fundsLimit = fundsLimit
        self.periodType = periodType
    }
    
}

public extension Category {
    enum CategoryType: String {
        case month = "month"
        case year = "year"
    }
}
