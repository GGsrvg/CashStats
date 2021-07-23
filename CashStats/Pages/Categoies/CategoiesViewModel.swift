//
//  CategoiesViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import DB
import Combine
import LDS

class CategoiesViewModel: BaseViewModel {
    
    let categories: ObservableDataSourceOneDimension<CategoryEntity> = .init()
    
    required init() {
        super.init()
        
        self.load()
    }
    
    func load() {
        self.bl.category.get()
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
                self.categories.set(value)
            }.store(in: &bag)
    }
}

