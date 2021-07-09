//
//  CategoryTableViewCellPresenter.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit

class CategoryTableViewCellPresenter {
    let title: String
    
    let periodName: String
    
    let spentFunds: Decimal
    
    let fundsLimit: Decimal
    
    let periodColor: UIColor
    
    internal init(title: String, periodName: String, spentFunds: Decimal, fundsLimit: Decimal, periodColor: UIColor) {
        self.title = title
        self.periodName = periodName
        self.spentFunds = spentFunds
        self.fundsLimit = fundsLimit
        self.periodColor = periodColor
    }
}

extension CategoryTableViewCellPresenter: Hashable {
    static func == (lhs: CategoryTableViewCellPresenter, rhs: CategoryTableViewCellPresenter) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(title.hash)
    }
}
