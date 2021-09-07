//
//  AddConsumptionContentType.swift
//  CashStats
//
//  Created by GGsrvg on 05.07.2021.
//

import Foundation

enum AddCategoryContentType {
    case textField(model: TextFieldPresenter)
    case segmentedControl(model: SegmentControlPresenter)
    case button(model: ButtonPresenter)
    case colorWell(model: ColorWellPresenter)
}

extension AddCategoryContentType: Equatable {
}
