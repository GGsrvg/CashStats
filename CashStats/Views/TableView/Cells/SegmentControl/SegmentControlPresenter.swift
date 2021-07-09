//
//  SegmentControlPresenter.swift
//  CashStats
//
//  Created by GGsrvg on 04.07.2021.
//

import Foundation

class SegmentControlPresenter {
    
    var selectedId: Int = 0
    let segments: [Segment]
    
    internal init(segments: [SegmentControlPresenter.Segment]) {
        self.segments = segments
    }
}

extension SegmentControlPresenter: Hashable {
    static func == (lhs: SegmentControlPresenter, rhs: SegmentControlPresenter) -> Bool {
        lhs === rhs
    }
    
    func hash(into hasher: inout Hasher) {
        
    }
}

extension SegmentControlPresenter {
    struct Segment {
        let id: Int
        let title: String
    }
}
