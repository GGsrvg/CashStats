//
//  BL.swift
//  BL
//
//  Created by GGsrvg on 26.06.2021.
//

import Foundation
import DB

public class BL {
    public static let current = BL()
    
    public let db = DataBase.current
    
    public let category: CategoryCase = .init()
    public let consumption: ConsumptionCase = .init()
    
    init() { }
}
