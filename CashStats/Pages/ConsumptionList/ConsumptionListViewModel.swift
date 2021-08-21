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
    
    @Published
    var contentState: ListContentState.TypeState = .content
    
    private var isFirstLoad = true
    
    private var isLoad = false
    
    private let countFetch = 100
    
    required init(category: DTO.Category) {
        self.category = category
        super.init()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func load(clear: Bool = false) {
        guard !isLoad else { return }
        isLoad = true
        
        if isFirstLoad {
            contentState = .load
            isFirstLoad = false
        }
        
        var fromIndex = 0
        if clear {
            self.consumptions.clear()
        } else {
            self.consumptions.array.forEach {
                fromIndex += $0.rows.count
            }
        }
        
        self.bl.consumption.get(by: self.category, from: fromIndex, count: countFetch)
            .tryCompactMap { (value: [DTO.Consumption]) ->  [Dictionary<Date, [Consumption]>.Element] in
                var dictionaryConsumption: [Date: [DTO.Consumption]] = [:]

                value.forEach {
                    let components = Calendar.current.dateComponents([.year, .month], from: $0.date)
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
                    self.contentState = self.consumptions.array.isEmpty ?
                        .error(title: "Empty", description: "No consumptions added. Click \"+\" to add.") : .content
                case .failure(let error):
                    self.isLoad = false
                    if self.consumptions.array.isEmpty {
                        self.contentState = .error(
                            title: "Error",
                            description: error.localizedDescription
                        )
                    }
                }
            } receiveValue: { sortedConsumption in
                var sections: [SectionItem<Date, DTO.Consumption, String?>] = []
                
                for (key, value) in sortedConsumption {
                    if self.consumptions.array.last?.header == key {
                        let lastSectionIndex = self.consumptions.array.count - 1
                        self.consumptions.addRows(value,
                                                  section: lastSectionIndex)
                    } else {
                        sections.append(.init(
                            header: key,
                            rows: value,
                            footer: ""
                        ))
                    }
                }
                
                if !sections.isEmpty {
                    self.consumptions.addSections(sections)
                }
            }.store(in: &bag)
    }
    
    
    func delete(indexPath: IndexPath) {
        let consumption = self.consumptions.array[indexPath.section].rows[indexPath.row]
        self.bl.consumption.delete(model: consumption)
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
                self.consumptions.removeRow(indexPath: indexPath)
            }.store(in: &bag)
    }
}
