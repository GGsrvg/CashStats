//
//  DataBase.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//


public final class DataBase {
    public static let current = DataBase()
    
    let stack: DatabaseStack
    
    public let category: CategoryCase
    
    init() {
        let stack = DatabaseStack()
        self.stack = stack
        self.category = .init(dbQueue: stack.dbQueue)
    }
}
