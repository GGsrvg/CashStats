//
//  BaseViewController.swift
//  CashStats
//
//  Created by GGsrvg on 26.06.2021.
//

import UIKit
import Combine

protocol BaseDataInitViewController {
    
}

struct EmptyDataInitViewController: BaseDataInitViewController {
    
}

class BaseViewController<VM: BaseViewModel, DI: BaseDataInitViewController>: UIViewController {
    
//    typealias DI = BaseDataInitViewController
    
    class func initWith(_ data: DI?) -> Self {
        fatalError("no can use default implementation")
    }
    
    let viewModel: VM
    
    var bag = Set<AnyCancellable>()
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
