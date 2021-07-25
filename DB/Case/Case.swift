//
//  Case.swift
//  DB
//
//  Created by GGsrvg on 23.07.2021.
//

import GRDB

public class Case {
    
    let dbQueue: DatabaseQueue
    
    init(dbQueue: DatabaseQueue) {
        self.dbQueue = dbQueue
        self.createTable()
    }
    
    /**
     You need override this method for create table.
     
     If you implement `Case` dont need call `super`.
     */
    func createTable() {
        
    }
}
