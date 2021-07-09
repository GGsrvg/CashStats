//
//  ButtonTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 05.07.2021.
//

import UIKit

class ButtonTableViewCell: UITableViewCell {
    @IBOutlet weak var button: UIButton! { didSet {
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 6
        button.addAction(UIAction(handler: { action in
            self.model?.tap()
        }), for: .touchUpInside)
    }}
    
    weak var model: ButtonPresenter? { didSet {
        guard let model = model else { return }
        
        button.setTitle(model.title, for: .normal)
        button.setBackgroundColor(model.color, forState: .normal)
    }}
}
