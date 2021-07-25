//
//  DataBaseStack.swift
//  DB
//
//  Created by GGsrvg on 02.07.2021.
//

import GRDB

final class DatabaseStack {
    
    let dbQueue: DatabaseQueue
    
    init() {
        let databaseURL = try! FileManager.default
            .url(for: .applicationSupportDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
            .appendingPathComponent("db.sqlite")
        
        guard let dbQueue = try? DatabaseQueue(path: databaseURL.path)
        else {
            fatalError("DatabaseQueue cannot init")
        }
        self.dbQueue = dbQueue
    }
}

