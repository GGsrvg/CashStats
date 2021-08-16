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
    
    let coordinator = DI.coordinator
    
    var bl: BL = DI.bisnesLayer
    
    required override init() {
        
    }
}
