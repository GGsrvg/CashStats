//
//  ColorWellPresenter.swift
//  CashStats
//
//  Created by GGsrvg on 08.07.2021.
//

import UIKit

class ColorWellPresenter {
    let title: String
    var selectedColor: UIColor?
    
    init(title: String, selectedColor: UIColor?) {
        self.title = title
        self.selectedColor = selectedColor
    }
}

extension ColorWellPresenter: Equatable {
    static func == (lhs: ColorWellPresenter, rhs: ColorWellPresenter) -> Bool {
        lhs === rhs
    }
}
