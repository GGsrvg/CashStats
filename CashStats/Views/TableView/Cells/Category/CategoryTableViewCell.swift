//
//  CategoryTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit
import DB

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var diagramSausage: DiagramSausageView! { didSet {
        diagramSausage.layer.cornerRadius = 6
        diagramSausage.layer.masksToBounds = true
    }}
    
    @IBOutlet weak var periodLabel: UILabel!
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    weak var model: CategoryEntity? { didSet {
        guard let model = model else { return }
        
        titleLabel.text = model.name
        periodLabel.text = model.periodType
        
        rangeLabel.text = "\(model.spentFunds ?? 0) / \(model.fundsLimit ?? 0) $"
        
        let intSpentFunds = UInt(truncating: model.spentFunds ?? 0)
        let intFundsLimit = UInt(truncating: model.fundsLimit ?? 0)
        
        diagramSausage.addItem(.init(
            color: UIColor(rgb: Int(model.colorHEX)),
            numberVotes: intSpentFunds
        ))
        diagramSausage.addItem(.init(
            color: .systemFill,
            numberVotes: intFundsLimit - intSpentFunds
        ))
    }}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        diagramSausage.clear()
    }
}
