//
//  UITableView+ListContentState.swift
//  CashStats
//
//  Created by GGsrvg on 11.08.2021.
//

import UIKit

extension UITableView {
    func setContentState(listContentState: ListContentState) {
        
        self.addSubview(listContentState)
        
        NSLayoutConstraint.activate([
            listContentState.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            listContentState.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
