//
//  DataBase.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//

import Foundation

public final class DataBase {
    public static let current = DataBase()
    
    let coreDataStack = CoreDataStack()
    
    public let categoryCase: GenericEntityCase<CategoryEntity>
    
    init() {
        categoryCase = .init(coreDataStack: self.coreDataStack)
        
    }
}
