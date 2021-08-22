//
//  UIView.swift
//  CashStats
//
//  Created by GGsrvg on 22.08.2021.
//

import UIKit

extension UIView {
    func subview(of classType: AnyClass?) -> UIView? {
        return subviews.first { type(of: $0) == classType }
    }
}
