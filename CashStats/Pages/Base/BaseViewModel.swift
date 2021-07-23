//
//  BaseViewModel.swift
//  CashStats
//
//  Created by GGsrvg on 26.06.2021.
//

import Foundation
import Combine
import BL

class BaseViewModel: NSObject {
    var bag = Set<AnyCancellable>()
    
    let coordinator = Consts.coordinator
    
    var bl: BL = Consts.bisnesLayer
    
    required override init() {
        
    }
}
