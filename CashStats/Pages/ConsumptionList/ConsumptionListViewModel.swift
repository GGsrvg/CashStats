//
//  ConsumptionListViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import Foundation
import LDS

class ConsumptionListViewModel: BaseViewModel {
    let сonsumptions: ObservableDataSourceTwoDimension<String, ConsumptionPresenter, String?> = .init()
    
    required init() {
        self.сonsumptions.set([
            .init(header: "test",
                  rows: [
                    .init(),
                    .init(),
                    .init(),
                    .init(),
                  ],
                  footer: nil)
        ])
    }
}
