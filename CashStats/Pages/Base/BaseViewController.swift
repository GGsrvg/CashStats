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
    
    private var _backTapGestureRecognizer: UITapGestureRecognizer?
    
    let viewModel: VM
    
    var bag = Set<AnyCancellable>()
    
    open var overrideBackButtonAction: Bool { get { false } }
    
    init(viewModel: VM) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.overrideBackButton()
    }
    
    private func overrideBackButton() {
        guard let navigationBar = self.navigationController?.navigationBar,
              let _UINavigationBarContentView = navigationBar.subview(of: NSClassFromString("_UINavigationBarContentView")),
              let back = _UINavigationBarContentView.subview(of: NSClassFromString("_UIButtonBarButton"))
        else { return }
        
        if overrideBackButtonAction {
            let backTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(_backButtonAction))
            back.addGestureRecognizer(backTapGestureRecognizer)
            if let _backTapGestureRecognizer = _backTapGestureRecognizer {
                back.removeGestureRecognizer(_backTapGestureRecognizer)
            }
            _backTapGestureRecognizer = backTapGestureRecognizer
        }
    }
    
    @objc private func _backButtonAction() {
        self.viewModel.close()
    }
}
