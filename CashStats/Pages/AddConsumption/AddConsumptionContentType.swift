//
//  AddConsumptionContentType.swift
//  CashStats
//
//  Created by GGsrvg on 13.07.2021.
//

import Foundation

enum AddConsumptionContentType {
    case textField(model: TextFieldPresenter)
    case date(model: DatePresenter)
}

extension AddConsumptionContentType: Equatable {
//    func hash(into hasher: inout Hasher) {
//        switch self {
//        case .textField(model: let model):
//            hasher.combine(model.hashValue)
//        case .date:
//            break
//        }
//    }
}
