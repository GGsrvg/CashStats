//
//  CategoiesViewController.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit
import LDS

class CategoiesViewController: BaseViewController<CategoiesViewModel> {
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var adapter: UITableViewAdapter<String?, CategoryTableViewCellPresenter, String?>!
    
    deinit {
        adapter?.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        navigationItem.backButtonTitle = "Back"
        
        navigationItem.rightBarButtonItems = [
            .init(systemItem: .add, primaryAction: .init(title: "test") { action in
                self.navigationController?.pushViewController(AddConsumptionViewController(), animated: true)
            }, menu: nil)
        ]
        
        adapter = .init(tableView)
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath)
            
            if let cell = cell as? CategoryTableViewCell {
                cell.presenter = model
            }
            
            return cell
        }
        adapter.numberOfItemsInSectionHandler = { _, _, _ in
            self.refreshControl.endRefreshing()
        }
        adapter.observableDataSource = viewModel.categories
        tableView.register(fromNib: CategoryTableViewCell.self)
        tableView.dataSource = adapter
        tableView.delegate = self
        
        
        refreshControl.addAction(.init(handler: { _ in
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
                self.viewModel.requestOnGet()
            }
        }), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension CategoiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        self.navigationController?.pushViewController(ConsumptionListViewController(), animated: true)
    }
}
