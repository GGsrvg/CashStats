//
//  ConsumptionTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 27.06.2021.
//

import UIKit
import DB

class ConsumptionTableViewCell: UITableViewCell {
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    weak var model: ConsumptionEntity? { didSet {
        guard let model = model else { return }
        dateLabel.text = model.date == nil ? "NONE" : String(describing: model.date!)
        titleLabel.text = model.name
        priceLabel.text = model.price == nil ? "NONE" : String(describing: model.price!)
        priceLabel.textColor = (model.price?.doubleValue ?? 0) < 0 ? .systemRed : .systemGreen
    }}
}
