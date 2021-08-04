//
//  ConsumptionListViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import DTO
import LDS

class ConsumptionListViewModel: BaseViewModel {
    
    let consumptions: ObservableDataSourceTwoDimension<Date, DTO.Consumption, String?> = .init()
    
    let category: DTO.Category
    
//    private var lastPosition = 0
    private let countFetch = 100
    
    required init(category: DTO.Category) {
        self.category = category
        super.init()
        self.load()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    private var isLoad = false
    func load(clear: Bool = false) {
        guard !isLoad else { return }
        isLoad = true
        
        var beforeCount = 0
        if clear {
            self.consumptions.clear()
        } else {
            self.consumptions.array.forEach {
                beforeCount += $0.rows.count
            }
        }
        
        self.bl.consumption.get(by: self.category, from: beforeCount, count: countFetch)
            .tryCompactMap { (value: [DTO.Consumption]) ->  [Dictionary<Date, [Consumption]>.Element] in
                var dictionaryConsumption: [Date: [DTO.Consumption]] = [:]

                value.forEach {
                    let components = Calendar.current.dateComponents([.year, .month, .day], from: $0.date)
                    let date = Calendar.current.date(from: components)!
                    
                    if dictionaryConsumption[date] == nil {
                        dictionaryConsumption[date] = []
                    }

                    dictionaryConsumption[date]?.append($0)
                }

                let sortedConsumption = dictionaryConsumption
                    .sorted(by: { $0.key > $1.key })

                return sortedConsumption
            }
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { fail in
                switch fail {
                case .finished:
                    self.isLoad = false
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { sortedConsumption in
                for (key, value) in sortedConsumption {
                    if self.consumptions.array.last?.header == key {
                        let lastSectionIndex = self.consumptions.array.count - 1
                        self.consumptions.addRows(value,
                                                  section: lastSectionIndex)
                    } else {
                        self.consumptions.addSections([
                            .init(
                                header: key,
                                rows: value,
                                footer: ""
                            )
                        ])
                    }
                }
            }.store(in: &bag)
    }
}
