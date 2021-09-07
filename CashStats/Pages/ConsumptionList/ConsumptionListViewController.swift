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
    
    fileprivate let dateFormatter: DateFormatter = {
        let dateFormatterTemplate = DateFormatter.dateFormat(
            fromTemplate: "MMMM yyyy",
            options: 0,
            locale: Locale.current
        )
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = dateFormatterTemplate
        return dateFormatter
    }()
    
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
    }
    
    private func setContentState() {
        tableView.setContentState(listContentState: listContentState)
        
        self.viewModel.$contentState
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] type in
                guard let self = self else { return }
                self.listContentState.change(to: type)
                
                if self.refreshControl.isRefreshing {
                    self.refreshControl.endRefreshing()
                }
                
                switch type {
                case .load:
                    self.tableView.isUserInteractionEnabled = false
                case .content:
                    self.tableView.isUserInteractionEnabled = true
                case .error:
                    self.tableView.isUserInteractionEnabled = true
                }
            })
            .store(in: &self.bag)
    }
    
    private func setTableAdapter() {
        adapter = .init(tableView)
        adapter.observableDataSource = viewModel.consumptions
        adapter.titleForHeaderSectionHandler = { [weak self] tableView, section in
            guard let self = self else { return nil }
            let date = self.viewModel.consumptions.array[section].header
            return self.dateFormatter.string(from: date)
        }
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: ConsumptionTableViewCell.reuseIdentifier, for: indexPath)
            if let cell = cell as? ConsumptionTableViewCell{
                cell.model = model
            }
            return cell
        }
        tableView.register(fromNib: ConsumptionTableViewCell.self)
        tableView.dataSource = adapter
        tableView.delegate = self
        tableView.refreshControl = refreshControl
        refreshControl.addAction(.init(handler: { _ in
            self.viewModel.load(clear: true)
        }), for: .valueChanged)
    }
}

extension ConsumptionListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, view, completion) in
            self.viewModel.delete(indexPath: indexPath)
            completion(true)
        }
        delete.backgroundColor = .systemRed
        
        let change = UIContextualAction(style: .destructive, title: "Chnage") { (action, view, completion) in
            let entity = self.viewModel.consumptions.array[indexPath.section].rows[indexPath.row]
            self.navigationController?.pushViewController(
                AddConsumptionViewController.initWith(
                    AddConsumptionDataInitViewController(
                        category: self.viewModel.category,
                        consumption: entity
                    )
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
    
    // пагинация на положение Y
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // with frame height
        let currentY = scrollView.contentOffset.y + scrollView.frame.size.height
        let maxY = max(scrollView.contentSize.height, scrollView.frame.height)
        if currentY > maxY {
            self.viewModel.load()
        }
    }
}
