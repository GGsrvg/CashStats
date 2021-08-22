//
//  DI.swift
//  CashStats
//
//  Created by GGsrvg on 26.06.2021.
//

import Foundation
import BL

class DI {
    static let coordinator = Coordinator()
    static let alertCoordinator = AlertCoordinator()
    static let bisnesLayer: BL = BL.current
}
