//
//  CategoiesViewController.swift
//  CashStats
//
//  Created by GGsrvg on 29.06.2021.
//

import UIKit
import LDS
import DTO

class CategoiesViewController: BaseViewController<CategoiesViewModel, EmptyDataInitViewController> {
    
    override class func initWith(_ data: EmptyDataInitViewController?) -> Self {
        return CategoiesViewController(viewModel: CategoiesViewModel()) as! Self
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    let refreshControl = UIRefreshControl()
    
    var adapter: UITableViewAdapter<String?, DTO.Category, String?>!
    
    deinit {
        adapter?.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Categories"
        navigationItem.backButtonTitle = "Back"
        navigationItem.rightBarButtonItems = [
            .init(systemItem: .add, primaryAction: .init(title: "test") { action in
                let vc = AddCategoryViewController.initWith(nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }, menu: nil)
        ]
        
        adapter = .init(tableView)
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath)
            
            if let cell = cell as? CategoryTableViewCell {
                cell.model = model
            }
            
            return cell
        }
        adapter.numberOfSectionsHandler = { _, _ in
            self.refreshControl.endRefreshing()
        }
        adapter.observableDataSource = viewModel.categories
        tableView.register(fromNib: CategoryTableViewCell.self)
        tableView.dataSource = adapter
        tableView.delegate = self
        
        refreshControl.addAction(.init(handler: { _ in
            self.viewModel.load()
        }), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}

extension CategoiesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let entity = self.viewModel.categories.array[indexPath.row]
        
        self.navigationController?.pushViewController(
            ConsumptionListViewController.initWith(
                ConsumptionListDataInitViewController(category: entity)
            ),
            animated: true
        )
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.viewModel.delete(indexPath: indexPath)
            completion(true)
        }
        delete.backgroundColor = .systemRed
        
        let change = UIContextualAction(style: .destructive, title: "Chnage") { (action, view, completion) in
            let entity = self.viewModel.categories.array[indexPath.row]
            self.navigationController?.pushViewController(
                AddCategoryViewController.initWith(
                    AddCategoryDataInitViewController(category: entity)
                ),
                animated: true
            )
            completion(true)
        }
        change.backgroundColor = .systemOrange
     
        let config = UISwipeActionsConfiguration(actions: [delete, change])
        config.performsFirstActionWithFullSwipe = true
     
        return config
    }
}

