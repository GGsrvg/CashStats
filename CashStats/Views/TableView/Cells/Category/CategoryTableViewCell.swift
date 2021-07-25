//
//  CategoryTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit
import DTO

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var diagramSausage: DiagramSausageView! { didSet {
        diagramSausage.layer.cornerRadius = 6
        diagramSausage.layer.masksToBounds = true
    }}
    
    @IBOutlet weak var periodLabel: UILabel!
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    var model: DTO.Category? { didSet {
        guard let model = model else { return }
        
        titleLabel.text = model.name
        periodLabel.text = "\(model.periodType ?? .month)"
        
        rangeLabel.text = "\(model.spentFunds) / \(model.fundsLimit) $"
        
        let intSpentFunds = UInt(model.spentFunds)
        let intFundsLimit = UInt(model.fundsLimit)
        
        let color = UIColor(rgb: model.colorHEX)
        diagramSausage.addItem(.init(
            color: color,
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
