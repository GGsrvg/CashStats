//
//  Category.swift
//  DB
//
//  Created by GGsrvg on 23.07.2021.
//

import GRDB
import DTO

struct Event {
    var id: Int64?
}

extension Event : FetchableRecord {
    init(row: Row) {
        id = row[Column.rowID]
    }
}

extension DTO.Category: FetchableRecord, MutablePersistableRecord {
    
    public static var databaseTableName: String = "Category"
    public static var databaseSelection: [SQLSelectable] = [AllColumns(), Column.rowID]
    
    public init(row: Row) {
        self.init(
            date: row["date"],
            name: row["name"],
            colorHEX: row["colorHEX"],
            spentFunds: row["spentFunds"],
            fundsLimit: row["fundsLimit"],
            periodTypeInt: row["periodTypeInt"]
        )
        self.id = row[Column.rowID]
    }
    
    public func encode(to container: inout PersistenceContainer) {
        container[Column.rowID] = self.id
        container["date"] = self.date
        container["name"] = self.name
        container["colorHEX"] = self.colorHEX
        container["spentFunds"] = self.spentFunds
        container["fundsLimit"] = self.fundsLimit
        container["periodTypeInt"] = self.periodTypeInt
    }
    
    // Update auto-incremented id upon successful insertion
    mutating public func didInsert(with rowID: Int64, for column: String?) {
        id = rowID
    }
}
