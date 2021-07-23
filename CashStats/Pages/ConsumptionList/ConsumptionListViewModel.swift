//
//  ConsumptionListViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import CoreData
import DB
import LDS

class ConsumptionListViewModel: BaseViewModel {
    
    let сonsumptions: ObservableDataSourceTwoDimension<String, ConsumptionEntity, String?> = .init()
    
    let category: CategoryEntity
    
    lazy var controller: NSFetchedResultsController<ConsumptionEntity> = {
        let controller = NSFetchedResultsController(
            fetchRequest: ConsumptionEntity.fetchRequest(),
            managedObjectContext: self.bl.db.context,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        controller.delegate = self
        return controller
    }()
    
    required init(category: CategoryEntity) {
        self.category = category
        super.init()
        self.load()
    }
    
    required init() {
        fatalError("init() has not been implemented")
    }
    
    func load() {
        self.bl.consumption.get(category: self.category)
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
                self.сonsumptions.set([
                    .init(header: "",
                          rows: value,
                          footer: ""
                    )
                ])
            }.store(in: &bag)
    }
}

extension ConsumptionListViewModel: NSFetchedResultsControllerDelegate {
    
}
