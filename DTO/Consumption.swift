//
//  Consumption.swift
//  DTO
//
//  Created by GGsrvg on 12.07.2021.
//

import Foundation

public struct Consumption: Codable {
    public let id: Int64
    public var date: Date
    public var name: String
    public var price: Double
    
    public init(id: Int64, date: Date, name: String, price: Double) {
        self.id = id
        self.date = date
        self.name = name
        self.price = price
    }
}
