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
                    t.column("date", .datetime).notNull()
                    t.column("name", .text).notNull()
                    t.column("price", .double).notNull()
                }
            }
        }
        
//        try? self.test()
    }
    
    #if DEBUG
    public func test() throws {
        // FOR TEST
        try dbQueue.write { db in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd.MM.yyyy"
            var day = 1
            for _ in 0...6 {
                day += 1
                for i in 0...Int.random(in: 0..<10) {
                    let dateStr = "\(day).04.2021"
                    var consumption = DTO.Consumption(
                        id: nil,
                        categoryId: 1,
                        date: dateFormatter.date(from: dateStr)!,
                        name: "Test #\(i)",
                        price: 1000
                    )
                    try consumption.save(db)
                }
            }
        }
    }
    #endif
    
    public func countAll() throws -> Int {
        return try dbQueue.read { db in
            try DTO.Consumption.fetchCount(db)
        }
    }
    
    public func fetch(by category: DTO.Category, from fromDate: Date, to toDate: Date) throws -> [DTO.Consumption] {
        return try dbQueue.read { db in
            try DTO.Consumption
                .order(Column.rowID.desc)
                .filter(DTO.Consumption.Columns.categoryId == category.id)
                .filter(DTO.Consumption.Columns.date > fromDate)
                .filter(DTO.Consumption.Columns.date < toDate)
                .fetchAll(db)
        }
    }
    
    public func fetch(by category: DTO.Category, from position: Int, count: Int) throws -> [DTO.Consumption] {
        return try dbQueue.read { db in
            try DTO.Consumption
                .order(Column.rowID.desc)
                .filter(DTO.Consumption.Columns.categoryId == category.id)
                .limit(count, offset: position)
                .fetchAll(db)
        }
    }
    
    public func save(consumption: DTO.Consumption) throws -> DTO.Consumption {
        var consumption = consumption
        try dbQueue.write { db in
            let oldCons = try DTO.Consumption.filter(Column.rowID == consumption.id)
                .fetchOne(db)
            
            let diffPrice = consumption.price - (oldCons?.price ?? 0)
            
            var category = try DTO.Category
                .filter(Column.rowID == consumption.categoryId)
                .fetchOne(db)
            
            category?.spentFunds += diffPrice
            try category?.save(db)
            
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
