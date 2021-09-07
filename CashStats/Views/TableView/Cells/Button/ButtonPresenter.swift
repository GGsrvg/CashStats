//
//  ButtonPresenter.swift
//  CashStats
//
//  Created by GGsrvg on 05.07.2021.
//

import UIKit

class ButtonPresenter {
    
    let title: String
    var color: UIColor
    private let tapHandler: (ButtonPresenter) -> Void
    
    init(title: String, color: UIColor, tapHandler: @escaping (ButtonPresenter) -> Void) {
        self.title = title
        self.color = color
        self.tapHandler = tapHandler
    }
    
    func tap() {
        self.tapHandler(self)
    }
}

extension ButtonPresenter: Equatable {
    static func == (lhs: ButtonPresenter, rhs: ButtonPresenter) -> Bool {
        lhs === rhs
    }
}
