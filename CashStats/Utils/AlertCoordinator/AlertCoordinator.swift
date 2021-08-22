//
//  AlertCoordinator.swift
//  CashStats
//
//  Created by GGsrvg on 21.08.2021.
//

import UIKit

final class AlertCoordinator {
    private var rootViewController: UIViewController? { get {
        return UIApplication.shared.windows.first?.rootViewController
    }}
    
    func alert(
        title: String?,
        message: String?,
        preferredStyle: UIAlertController.Style,
        actions: [UIAlertAction]
    ) {
        guard let rootViewController = rootViewController else { return }
        
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: preferredStyle
        )

        actions.forEach { alert.addAction($0) }
        
        rootViewController.present(alert, animated: true, completion: nil)
    }
}
