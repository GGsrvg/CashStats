//
//  TextFieldPresenter.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import UIKit

class TextFieldPresenter {
    let title: String
    let placeholder: String?
    var value: String?
    let keyboardType: UIKeyboardType
    
    internal init(title: String, placeholder: String?, value: String?, keyboardType: UIKeyboardType) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.keyboardType = keyboardType
    }

}

extension TextFieldPresenter: Hashable {
    static func == (lhs: TextFieldPresenter, rhs: TextFieldPresenter) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}
