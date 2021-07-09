//
//  ColorWellTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 08.07.2021.
//

import UIKit

class ColorWellTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var colorWell: UIColorWell = {
        let colorWell = UIColorWell()
        colorWell.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            self.model?.selectedColor = colorWell.selectedColor
        }), for: .valueChanged)
        colorWell.supportsAlpha = false
        colorWell.translatesAutoresizingMaskIntoConstraints = false
        return colorWell
    }()
    
    weak var model: ColorWellPresenter? { didSet {
        guard let model = model else { return }
        titleLabel.text = model.title
        colorWell.selectedColor = model.selectedColor
    }}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setView()
    }
    
    private func setView() {
        selectionStyle = .none
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(colorWell)
        
        setConstraints()
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            titleLabel.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            
            colorWell.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 12),
            colorWell.topAnchor.constraint(equalTo: contentView.layoutMarginsGuide.topAnchor),
            contentView.layoutMarginsGuide.trailingAnchor.constraint(equalTo: colorWell.trailingAnchor),
            contentView.layoutMarginsGuide.bottomAnchor.constraint(equalTo: colorWell.bottomAnchor),
        ])
    }
}
