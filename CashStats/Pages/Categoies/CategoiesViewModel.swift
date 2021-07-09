//
//  CategoiesViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import Foundation
import Combine
import LDS

class CategoiesViewModel: BaseViewModel {
    
    let categories: ObservableDataSourceOneDimension<CategoryTableViewCellPresenter> = .init()
    
    required init() {
        super.init()
//        self.bl.category.add(models: [
//            .init(colorHEX: "#000000", costsForPeriod: 643.2, name: "kek2", periodLimit: 1000, periodType: "month")
//        ])
//        .subscribe(on: DispatchQueue.global())
//        .receive(on: DispatchQueue.main)
//        .sink { fail in
//            switch fail {
//            case .finished:
//                print("finished")
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        } receiveValue: { value in
//            print("value")
//        }.store(in: &bag)
        
        self.requestOnGet()
    }
    
    func requestOnGet() {
        self.bl.category.get()
            .compactMap({ categories in
                return categories.compactMap {
                    CategoryTableViewCellPresenter(
                        title: $0.name,
                        periodName: $0.periodType.rawValue,
                        spentFunds: $0.spentFunds,
                        fundsLimit: $0.fundsLimit,
                        periodColor: UIColor(rgb: Int($0.colorHEX) ?? 0x000000)
                    )
                }
            })
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

