//
//  DatePresenter.swift
//  CashStats
//
//  Created by GGsrvg on 17.07.2021.
//

import Foundation

class DatePresenter {
    internal init(date: Date = .init()) {
        self.date = date
    }
    
    var date: Date
}

extension DatePresenter: Hashable {
    static func == (lhs: DatePresenter, rhs: DatePresenter) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(date.hashValue)
    }
}
