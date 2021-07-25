//
//  UIColor.swift
//  CashStats
//
//  Created by GGsrvg on 09.07.2021.
//

import UIKit

extension UIColor {
    convenience init(rgb: Int) {
        let iBlue = rgb & 0xFF
        let iGreen =  (rgb >> 8) & 0xFF
        let iRed =  (rgb >> 16) & 0xFF
        let iAlpha =  (rgb >> 24) & 0xFF
        self.init(red: CGFloat(iRed)/255, green: CGFloat(iGreen)/255,
                  blue: CGFloat(iBlue)/255, alpha: CGFloat(iAlpha)/255)
    }
    
    func rgb() -> Int {
        var red : CGFloat = 0
        var green : CGFloat = 0
        var blue : CGFloat = 0
        var alpha: CGFloat = 0
        if self.getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
            let iRed = Int(red * 255.0)
            let iGreen = Int(green * 255.0)
            let iBlue = Int(blue * 255.0)
            let iAlpha = Int(alpha * 255.0)
            
            //  (Bits 24-31 are alpha, 16-23 are red, 8-15 are green, 0-7 are blue).
            let rgb = (iAlpha << 24) + (iRed << 16) + (iGreen << 8) + (iBlue << 0)
            return rgb
        } else {
            fatalError("Cant calculate color")
        }
    }
}
