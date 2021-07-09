//
//  CategoryTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var diagramSausage: DiagramSausageView! { didSet {
        diagramSausage.layer.cornerRadius = 6
        diagramSausage.layer.borderWidth = 2
        diagramSausage.layer.borderColor = UIColor.black.cgColor
        diagramSausage.layer.masksToBounds = true
    }}
    
    @IBOutlet weak var periodLabel: UILabel!
    
    @IBOutlet weak var rangeLabel: UILabel!
    
    weak var presenter: CategoryTableViewCellPresenter? { didSet {
        guard let presenter = presenter else { return }
        
        titleLabel.text = presenter.title
        periodLabel.text = presenter.periodName
        rangeLabel.text = "\(presenter.spentFunds) / \(presenter.fundsLimit) $"
        
        diagramSausage.addItem(.init(color: presenter.periodColor, numberVotes: UInt(truncating: NSDecimalNumber(decimal: presenter.spentFunds))))
        diagramSausage.addItem(.init(color: .white, numberVotes: UInt(truncating: NSDecimalNumber(decimal:presenter.fundsLimit - presenter.spentFunds))))
    }}
    
    override func prepareForReuse() {
        super.prepareForReuse()
        diagramSausage.clear()
    }
}
