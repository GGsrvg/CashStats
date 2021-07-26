//
//  File.swift
//  DB
//
//  Created by GGsrvg on 23.07.2021.
//

import GRDB
import DTO

extension DTO.Consumption: FetchableRecord, MutablePersistableRecord {
    
    public static var databaseTableName: String = String(describing: Self.self)
    public static var databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    enum Columns: String, ColumnExpression {
        case id, categoryId, date, name, price
    }
    
    public init(row: Row) {
        self.init(
            id: row[Column.rowID],
            categoryId: row["categoryId"],
            date: row["date"],
            name: row["name"],
            price: row["price"]
        )
    }
    
    public func encode(to container: inout PersistenceContainer) {
        container[Column.rowID] = self.id
        container["categoryId"] = self.categoryId
        container["date"] = self.date
        container["name"] = self.name
        container["price"] = self.price
    }
    
    // Update auto-incremented id upon successful insertion
    mutating public func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
