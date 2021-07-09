//
//  DiagramSausageView.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit

@IBDesignable class DiagramSausageView: UIView {
    
    private var items: [DiagramItem] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.backgroundColor = .clear
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        self.addItem(.init(color: .systemYellow, numberVotes: 10))
        self.addItem(.init(color: .white, numberVotes: 10))
    }
    
    override func draw(_ rect: CGRect) {
        let fullWidth = rect.width
        let fullHeight = rect.height
        var allNumberVotes: CGFloat = 0
        self.items.forEach {
            allNumberVotes += CGFloat($0.numberVotes)
        }
        
        var continueX: CGFloat = 0
        
        items.forEach { item in
            let width = fullWidth * CGFloat(item.numberVotes) / allNumberVotes
            defer {
                continueX += width
            }
            
            let path = UIBezierPath(rect: .init(x: continueX, y: 0, width: width, height: fullHeight))
            item.color.setFill()
            path.fill()
        }
    }
    
    func clear() {
        items = []
    }
    
    func addItem(_ item: DiagramItem) {
        items.append(item)
        setNeedsDisplay()
    }
}
