//
//  Consumption.swift
//  DTO
//
//  Created by GGsrvg on 12.07.2021.
//

import Foundation

public struct Consumption: Codable {
    public var id: Int64?
    public var categoryId: Int64
    public var date: Date
    public var name: String
    public var price: Double
    
    public init(id: Int64?, categoryId: Int64, date: Date, name: String, price: Double) {
        self.id = id
        self.categoryId = categoryId
        self.date = date
        self.name = name
        self.price = price
    }
}

extension Consumption: Hashable {
    
}
