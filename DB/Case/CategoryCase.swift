//
//  CategoryCase.swift
//  DB
//
//  Created by GGsrvg on 23.07.2021.
//

import GRDB
import DTO

final public class CategoryCase: Case {
    
    override func createTable() {
        try? dbQueue.write { db in
            if try db.tableExists(DTO.Category.databaseTableName) == false {
                try db.create(table: DTO.Category.databaseTableName) { t in
                    t.column("date", .date).notNull()
                    t.column("name", .text).notNull()
                    t.column("colorHEX", .integer).notNull()
                    t.column("spentFunds", .double).notNull()
                    t.column("fundsLimit", .double).notNull()
                    t.column("periodTypeInt", .integer).notNull()
                }
            }
        }
    }
    
    public func fetch() throws -> [DTO.Category] {
        return try dbQueue.read { db in
            try DTO.Category.fetchAll(db)
        }
    }
    
    public func save(category: DTO.Category) throws -> DTO.Category {
        var category = category
        try dbQueue.write { db in
            try category.save(db)
        }
        return category
    }
    
    public func delete(category: DTO.Category) throws {
        try dbQueue.write { db -> Void in
            try category.delete(db)
        }
    }
}
