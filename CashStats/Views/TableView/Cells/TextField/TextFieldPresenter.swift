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
    let textFieldDelegate: UITextFieldDelegate?
    
    internal init(
        title: String,
        placeholder: String?,
        value: String?,
        keyboardType: UIKeyboardType = .default,
        textFieldDelegate: UITextFieldDelegate? = nil
    ) {
        self.title = title
        self.placeholder = placeholder
        self.value = value
        self.keyboardType = keyboardType
        self.textFieldDelegate = textFieldDelegate
    }

}

extension TextFieldPresenter: Equatable {
    static func == (lhs: TextFieldPresenter, rhs: TextFieldPresenter) -> Bool {
        lhs === rhs
    }
}
