//
//  CategoiesViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import DTO
import Combine
import LDS

class CategoiesViewModel: BaseViewModel {
    
    let categories: ObservableDataSourceOneDimension<DTO.Category> = .init()
    
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
    
    func delete(indexPath: IndexPath) {
        let category = self.categories.array[indexPath.row]
        self.bl.category.delete(model: category)
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
                self.categories.removeRow(at: indexPath.row)
            }.store(in: &bag)
    }
}

