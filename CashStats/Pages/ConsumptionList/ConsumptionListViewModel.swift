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
    
    private var lastPosition = 0
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
    
    func load(from position: Int = 0) {
        guard position % countFetch == 0
        else { return }
        
        // if lastPosition less or equil position and position equail zero
        // then reset pagination
        if lastPosition < position {
            if position == 0 {
               return
            }
            lastPosition = position
            consumptions.addSections([
                .init(
                    header: "",
                    rows: [],
                    footer: ""
                )
            ])
        }
        
        self.bl.consumption.get(by: self.category, from: position, count: countFetch)
            .subscribe(on: DispatchQueue.global())
            .receive(on: DispatchQueue.main)
            .sink { fail in
                switch fail {
                case .finished:
                    print("finished")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { value in
                self.lastPosition = position + self.countFetch
                DispatchQueue.main.async {
                    self.consumptions.addRows(value, section: 0)
                }
            }.store(in: &bag)
    }
}
