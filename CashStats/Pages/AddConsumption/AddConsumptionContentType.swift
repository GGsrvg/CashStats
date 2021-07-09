//
//  AddConsumptionContentType.swift
//  CashStats
//
//  Created by GGsrvg on 05.07.2021.
//

import Foundation

enum AddConsumptionContentType {
    case textField(model: TextFieldPresenter)
    case segmentedControl(model: SegmentControlPresenter)
    case button(model: ButtonPresenter)
    case colorWell(model: ColorWellPresenter)
}

extension AddConsumptionContentType: Hashable {
    func hash(into hasher: inout Hasher) {
        switch self {
        case .textField(model: let model):
            hasher.combine(model.hashValue)
        case .segmentedControl(model: let model):
            hasher.combine(model.hashValue)
        case .button(model: let model):
            hasher.combine(model.hashValue)
        case .colorWell(model: let model):
            hasher.combine(model.hashValue)
        }
    }
}
