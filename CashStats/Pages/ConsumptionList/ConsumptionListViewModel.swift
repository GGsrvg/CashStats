//
//  ConsumptionListViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import DTO
import LDS

class ConsumptionListViewModel: BaseViewModel {
    
    let consumptions: ObservableDataSourceTwoDimension<String, DTO.Consumption, String?> = .init()
    
    let category: DTO.Category
    
//    private var lastPosition = 0
    private let countFetch = 100
    
    required init(category: DTO.Category) {
        self.category = category
        super.init()
        self.consumptions.addSections([
            .init(
                header: "",
                rows: [],
                footer: ""
            )
        ])
        self.load()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
//    func refresh() {
//        lastPosition = 0
//        pagingLoad()
//    }
    
//    func pagingLoad() {
//        load(from: lastPosition + countFetch)
//    }
    
    private var isLoad = false
    func load(clear: Bool? = false) {
        guard !isLoad
        else { return }
        
        isLoad = true
        
        var beforeCount = 0
        self.consumptions.array.forEach {
            beforeCount += $0.rows.count
        }
        self.bl.consumption.get(by: self.category, from: beforeCount, count: countFetch)
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
            } receiveValue: { value in
                self.consumptions.addRows(value, section: 0)
            }.store(in: &bag)
    }
}
