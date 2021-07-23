//
//  CategoryTableViewCellPresenter.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit
import DB

//class CategoryTableViewCellPresenter {
//    let entity: CategoryEntity?
//    
//    let title: String
//    
//    let periodName: String
//    
//    let spentFunds: Decimal
//    
//    let fundsLimit: Decimal
//    
//    let periodColor: UIColor
//    
//    init(
//        title: String,
//        periodName: String,
//        spentFunds: Decimal,
//        fundsLimit: Decimal,
//        periodColor: UIColor
//    ) {
//        self.entity = nil
//        self.title = title
//        self.periodName = periodName
//        self.spentFunds = spentFunds
//        self.fundsLimit = fundsLimit
//        self.periodColor = periodColor
//    }
//    
//    init(from entity: CategoryEntity) {
//        self.entity = entity
//        self.title = entity.name ?? ""
//        self.periodName = entity.periodType ?? ""
//        self.spentFunds = entity.spentFunds?.decimalValue ?? 0
//        self.fundsLimit = entity.fundsLimit?.decimalValue ?? 0
//        self.periodColor = UIColor(rgb: Int(entity.colorHEX))
//    }
//}
//
//extension CategoryTableViewCellPresenter: Hashable {
//    static func == (lhs: CategoryTableViewCellPresenter, rhs: CategoryTableViewCellPresenter) -> Bool {
//        lhs === rhs
//    }
//    
//    func hash(into hasher: inout Hasher) {
//        hasher.combine(title.hash)
//    }
//}
