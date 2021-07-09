//
//  Coordinator.swift
//  CashStats
//
//  Created by GGsrvg on 06.07.2021.
//

import UIKit

final class Coordinator {
    private let navigationController = UINavigationController()
    
    func getSuperViewController() -> UIViewController {
        return navigationController
    }
    
    func setRoot(_ viewController: UIViewController) {
        navigationController.viewControllers = [viewController]
    }
    
    func popTo() {
        navigationController.popViewController(animated: true)
    }
    
    func pushTo(_ viewController: UIViewController) {
        navigationController.present(viewController, animated: true, completion: nil)
    }
}
