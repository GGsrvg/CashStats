//
//  TextFieldTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import UIKit

class TextFieldTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var textField: UITextField! { didSet {
        textField.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            self.model?.value = self.textField.text
        }), for: .editingChanged)
    }}
    
    weak var model: TextFieldPresenter? { didSet {
        guard let model = model else { return }
        
        titleLabel.text = model.title
        textField.text = model.value
        textField.placeholder = model.placeholder
        textField.keyboardType = model.keyboardType
        textField.delegate = model.textFieldDelegate
    }}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            textField.becomeFirstResponder()
        }
    }
}
