//
//  AddConsumptionViewController.swift
//  CashStats
//
//  Created by GGsrvg on 13.07.2021.
//

import UIKit
import LDS

class AddConsumptionViewController: BaseViewController<AddConsumptionViewModel, AddConsumptionDataInitViewController> {

    override class func initWith(_ data: AddConsumptionDataInitViewController?) -> Self {
        guard let data = data else { fatalError("need set data") }
        
        return AddConsumptionViewController(viewModel: AddConsumptionViewModel(category: data.category)) as! Self
    }
    
    var adapter: UITableViewAdapter<String?, AddConsumptionContentType, String?>!
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        adapter.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Add Consumption"
        navigationItem.rightBarButtonItems = [
            .init(systemItem: .add, primaryAction: .init(handler: { action in
                self.viewModel.save()
            }))
        ]
        
        adapter = .init(self.tableView)
        adapter.observableDataSource = self.viewModel.fields
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell: UITableViewCell
            
            switch model {
            case .textField(model: let model):
                cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath)
                
                if let cell = cell as? TextFieldTableViewCell {
                    cell.model = model
                }
            case .date(model: let model):
                cell = tableView.dequeueReusableCell(withIdentifier: DateTableViewCell.reuseIdentifier, for: indexPath)
                
                if let cell = cell as? DateTableViewCell {
                    cell.model = model
                }
            }
            
            return cell
        }
        tableView.register(fromNib: TextFieldTableViewCell.self)
        tableView.register(fromNib: DateTableViewCell.self)
        tableView.dataSource = adapter
    }
}
