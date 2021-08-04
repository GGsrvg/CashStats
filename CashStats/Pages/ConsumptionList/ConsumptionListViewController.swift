//
//  ConsumptionListViewController.swift
//  CashStats
//
//  Created by GGsrvg on 27.06.2021.
//

import UIKit
import LDS
import DTO

fileprivate let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateStyle = .long
    return dateFormatter
}()

class ConsumptionListViewController: BaseViewController<ConsumptionListViewModel, ConsumptionListDataInitViewController> {
    
    override class func initWith(_ data: ConsumptionListDataInitViewController?) -> Self {
        guard let data = data else { fatalError("data need set") }
        
        let vm = ConsumptionListViewModel(category: data.category)
        let vc = ConsumptionListViewController(viewModel: vm)
        vc.navigationItem.title = data.category.name
        return vc as! Self
    }
    
    var adapter: UITableViewAdapter<Date, DTO.Consumption, String?>!
    
    let refreshControl = UIRefreshControl()
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        adapter?.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.index
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
        adapter.observableDataSource = viewModel.consumptions
        adapter.titleForHeaderSectionHandler = { [weak self] tableView, section in
            guard let self = self else { return nil }
            let date = self.viewModel.consumptions.array[section].header
            return dateFormatter.string(from: date)
        }
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: ConsumptionTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? ConsumptionTableViewCell{
                cell.model = model
            }
            return cell
        }
//        adapter.numberOfSectionsHandler = { _, _ in
//            self.refreshControl.endRefreshing()
//        }
        tableView.register(fromNib: ConsumptionTableViewCell.self)
        tableView.dataSource = adapter
        tableView.delegate = self
        
//        refreshControl.addAction(.init(handler: { _ in
//            self.viewModel.load(clear: true)
//        }), for: .valueChanged)
//        tableView.refreshControl = refreshControl
    }
}

extension ConsumptionListViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (((scrollView.contentOffset.y + scrollView.frame.size.height) > scrollView.contentSize.height )){
            self.viewModel.load()
        }
    }
}
