//
//  Double.swift
//  CashStats
//
//  Created by GGsrvg on 21.08.2021.
//

import Foundation

extension Double {
    var optimalString: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
