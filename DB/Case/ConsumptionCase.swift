//
//  ConsumptionCase.swift
//  DB
//
//  Created by GGsrvg on 25.07.2021.
//

import GRDB
import DTO

final public class ConsumptionCase: Case {
    override func createTable() {
        try? dbQueue.write { db in
            if try db.tableExists(DTO.Consumption.databaseTableName) == false {
                try db.create(table: DTO.Consumption.databaseTableName) { t in
                    t.column("categoryId", .integer).notNull()
                    t.column("date", .date).notNull()
                    t.column("name", .text).notNull()
                    t.column("price", .double).notNull()
                }
            }
            
            // FOR TEST
//            for i in 0...1000 {
//                var consumption = DTO.Consumption(id: nil, categoryId: 1, date: Date(), name: "Test #\(i)", price: 1000)
//                try consumption.save(db)
//            }
        }
    }
    
    public func fetch(by category: DTO.Category, from position: Int, count: Int) throws -> [DTO.Consumption] {
        return try dbQueue.read { db in
            try DTO.Consumption
                .order(Column.rowID.desc)
//                .filter(Column("categoryId") == category.id)
                .limit(count, offset: position)
                .fetchAll(db)
        }
    }
    
    public func save(consumption: DTO.Consumption) throws -> DTO.Consumption {
        var consumption = consumption
        try dbQueue.write { db in
            try consumption.save(db)
        }
        return consumption
    }
    
    public func delete(consumption: DTO.Consumption) throws {
        try dbQueue.write { db -> Void in
            try consumption.delete(db)
        }
    }
}
