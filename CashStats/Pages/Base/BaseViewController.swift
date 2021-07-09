//
//  BaseViewController.swift
//  CashStats
//
//  Created by GGsrvg on 26.06.2021.
//

import UIKit

protocol BaseDataInitViewController {
    
}

class BaseViewController<VM: BaseViewModel>: UIViewController {
    
    typealias DI = BaseDataInitViewController
    
    class func initWith(_ data: DI?) -> Self? {
        return nil
    }
    
    let viewModel: VM
    
    init() {
        self.viewModel = .init()
        super.init(nibName: nil, bundle: nil)
        
//        self.viewModel.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//extension BaseViewController: BaseViewModelDelegate {
//    func navigate(to viewController: UIViewController) {
//        self.navigationController?.present(viewController, animated: true, completion: nil)
//    }
//
//    func close() {
//        self.navigationController?.popViewController(animated: true)
//    }
//}
