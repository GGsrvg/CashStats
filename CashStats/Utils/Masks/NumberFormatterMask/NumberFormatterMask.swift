//
//  NumberFormatterMask.swift
//  CashStats
//
//  Created by GGsrvg on 16.08.2021.
//

import UIKit

final class NumberFormatterMask: NSObject, UITextFieldDelegate {
    
    fileprivate static weak var _shared: NumberFormatterMask?
    
    static var shared: NumberFormatterMask { get {
        let shared = _shared ?? NumberFormatterMask()
        _shared = shared
        return shared
    }}
    
    fileprivate override init() {
        super.init()
    }
    
    lazy var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text,
           let textRange = Range(range, in: text) {
            let updatedText = text
                .replacingCharacters(in: textRange, with: string)
                .components(separatedBy: CharacterSet.decimalDigits.inverted)
                .joined()
            
            let number = NSNumber(value: Int(updatedText) ?? 0)
            
            textField.text = numberFormatter.string(from: number)
            textField.sendActions(for: .editingChanged)
        }
        return false
    }
}
