//
//  EasyRegisterCell.swift
//  CashStats
//
//  Created by GGsrvg on 28.06.2021.
//

import UIKit

extension UIView {
    static var reuseIdentifier: String { String(describing: self) }
    static var nib: UINib { UINib(nibName: reuseIdentifier, bundle: nil) }
}

extension UITableView {
    func register<C: UITableViewCell>(cell: C.Type) {
        self.register(cell, forCellReuseIdentifier: cell.reuseIdentifier)
    }
    
    func register<C: UITableViewCell>(fromNib cell: C.Type) {
        self.register(cell.nib, forCellReuseIdentifier: cell.reuseIdentifier)
    }
}

extension UICollectionView {
    func register<C: UICollectionViewCell>(cell: C.Type) {
        self.register(cell, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
    
    func register<C: UICollectionViewCell>(fromNib cell: C.Type) {
        self.register(cell.nib, forCellWithReuseIdentifier: cell.reuseIdentifier)
    }
}
