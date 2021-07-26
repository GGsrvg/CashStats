//
//  ConsumptionListViewController.swift
//  CashStats
//
//  Created by GGsrvg on 27.06.2021.
//

import UIKit
import LDS
import DTO

class ConsumptionListViewController: BaseViewController<ConsumptionListViewModel, ConsumptionListDataInitViewController> {
    
    override class func initWith(_ data: ConsumptionListDataInitViewController?) -> Self {
        guard let data = data else { fatalError("data need set") }
        
        let vm = ConsumptionListViewModel(category: data.category)
        let vc = ConsumptionListViewController(viewModel: vm)
        vc.navigationItem.title = data.category.name
        return vc as! Self
    }
    
    var adapter: UITableViewAdapter<String, DTO.Consumption, String?>!
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        adapter?.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItems = [
            .init(systemItem: .add, primaryAction: .init() { action in
                self.navigationController?.pushViewController(
                    AddConsumptionViewController.initWith(
                        AddConsumptionDataInitViewController(
                            category: self.viewModel.category,
                            consumption: nil
                        )
                    ),
                    animated: true
                )
            }, menu: nil)
        ]
        
        adapter = .init(tableView)
        adapter.observableDataSource = viewModel.сonsumptions
        adapter.titleForHeaderSectionHandler = { [weak self] tableView, section in
            guard let self = self else { return nil }
            return self.viewModel.сonsumptions.array[section].header
        }
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: ConsumptionTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? ConsumptionTableViewCell{
                cell.model = model
            }
            return cell
        }
        adapter.numberOfSectionsHandler = { _, _ in
            self.refreshControl.endRefreshing()
        }
        tableView.register(fromNib: ConsumptionTableViewCell.self)
        tableView.dataSource = adapter
        
        refreshControl.addAction(.init(handler: { _ in
            self.viewModel.load()
        }), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
}
