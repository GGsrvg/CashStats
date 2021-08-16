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
    
    let listContentState: ListContentState = {
        let listContentState = ListContentState()
        listContentState.translatesAutoresizingMaskIntoConstraints = false
        return listContentState
    }()
    
    deinit {
        adapter?.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setNavItem()
        self.setContentState()
        self.setTableAdapter()
        self.viewModel.load()
    }
    
    private func setNavItem() {
        title = "Categories"
        navigationItem.backButtonTitle = "Back"
        navigationItem.rightBarButtonItems = [
            .init(systemItem: .add, primaryAction: .init(title: "test") { action in
                let vc = AddCategoryViewController.initWith(nil)
                self.navigationController?.pushViewController(vc, animated: true)
            }, menu: nil)
        ]
    }
    
    private func setContentState() {
        tableView.setContentState(listContentState: listContentState)
        
        self.viewModel.$contentState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { type in
                self.listContentState.change(to: type)
                self.refreshControl.endRefreshing()
                
                switch type {
                case .load:
                    self.tableView.separatorStyle = .none
                    self.tableView.isUserInteractionEnabled = false
                case .content:
                    self.tableView.separatorStyle = .singleLine
                    self.tableView.isUserInteractionEnabled = true
                case .error:
                    self.tableView.separatorStyle = .none
                    self.tableView.isUserInteractionEnabled = true
                }
            })
            .store(in: &self.bag)
    }
    
    private func setTableAdapter() {
        adapter = .init(tableView)
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: CategoryTableViewCell.reuseIdentifier, for: indexPath)
            
            if let cell = cell as? CategoryTableViewCell {
                cell.model = model
            }
            
            return cell
        }
        adapter.observableDataSource = viewModel.categories
        tableView.register(fromNib: CategoryTableViewCell.self)
        tableView.dataSource = adapter
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addAction(.init(handler: { _ in
            self.viewModel.load()
        }), for: .valueChanged)
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

