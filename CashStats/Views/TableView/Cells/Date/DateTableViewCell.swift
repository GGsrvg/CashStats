//
//  DateTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 13.07.2021.
//

import UIKit

class DateTableViewCell: UITableViewCell {

    @IBOutlet weak var datePicker: UIDatePicker! { didSet {
        datePicker.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            self.model?.date = self.datePicker.date
        }), for: .valueChanged)
    }}
    
    weak var model: DatePresenter? { didSet {
        guard let model = model else { return }
        
        datePicker.date = model.date
    }}
}
