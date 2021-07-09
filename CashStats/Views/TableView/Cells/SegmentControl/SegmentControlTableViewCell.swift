//
//  SegmentControlTableViewCell.swift
//  CashStats
//
//  Created by GGsrvg on 04.07.2021.
//

import UIKit

class SegmentControlTableViewCell: UITableViewCell {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl! { didSet {
        segmentedControl.addAction(UIAction(handler: { [weak self] action in
            guard let self = self else { return }
            self.model?.selectedId = self.segmentedControl.selectedSegmentIndex
        }), for: .valueChanged)
    }}
    
    weak var model: SegmentControlPresenter? { didSet {
        guard let model = model else { return }
        
        segmentedControl.removeAllSegments()
        
        var i = 0
        model.segments.forEach {
            self.segmentedControl.insertSegment(withTitle: $0.title, at: i, animated: false)
            i += 1
        }
        
        segmentedControl.selectedSegmentIndex = model.selectedId
    }}
}
