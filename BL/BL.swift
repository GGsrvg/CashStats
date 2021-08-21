//
//  BL.swift
//  BL
//
//  Created by GGsrvg on 26.06.2021.
//

import Foundation
import Combine
import DB

public class BL {
    private var bag = Set<AnyCancellable>()
    
    public static let current = BL()
    
    public let db = DataBase.current
    
    public let category: CategoryCase = .init()
    public let consumption: ConsumptionCase = .init()
    
    init() { }
    
    public func calculateConsumption() {
        /*
         получить траты за месяц
         разбить на катягории
         в каждрой категории суммировать суммы трат
         сохранить
         */
        
        let currentDate = Date()
        let calendar = Calendar.current
//        let startDateComponent = calendar.dateComponents([.month, .year], from: currentDate)
//
//        var endDateComponent = DateComponents()
//        endDateComponent.month = 1
//        endDateComponent.day = 0
        
        guard let timeInterval = calendar.dateInterval(of: .month, for: currentDate)
        else { return }
        
        let startOfMonth = timeInterval.start
        let endOfMonth = timeInterval.end
        
        self.category.get()
            .sink { completion in
                switch completion {
                case .finished:
                    return
                case .failure(_):
                    return
                }
            } receiveValue: { categories in
                for category in categories {
                    guard let consumptions = try? self.db.consumption.fetch(
                        by: category,
                        from: startOfMonth,
                        to: endOfMonth
                    ) else { continue }
                    
                    var spentFunds: Double = 0
                    
                    consumptions.forEach {
                        spentFunds += $0.price
                    }
                    
                    var saveCategory = category
                    saveCategory.spentFunds = spentFunds
                    
                    _ = try? self.db.category.save(category: saveCategory)
                }
            }
            .store(in: &self.bag)

    }
}
