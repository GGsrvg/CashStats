//
//  AddConsumptionViewController.swift
//  CashStats
//
//  Created by GGsrvg on 01.07.2021.
//

import UIKit
import LDS

class AddConsumptionViewController: BaseViewController<AddConsumptionViewModel> {
    
    var adapter: UITableViewAdapter<String?, AddConsumptionContentType, String?>!
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        adapter.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Add cunsumption" 
        navigationItem.rightBarButtonItems = [
            .init(systemItem: .save, primaryAction: UIAction(handler: { action in
                self.viewModel.save()
            }), menu: nil)
        ]
        
        adapter = .init(tableView)
        adapter.observableDataSource = viewModel.fields
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let commonCell: UITableViewCell
            
            switch model {
            case .textField(model: let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: TextFieldTableViewCell.reuseIdentifier, for: indexPath)
                commonCell = cell
                
                if let cell = cell as? TextFieldTableViewCell {
                    cell.model = model
                }
            case .segmentedControl(model: let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: SegmentControlTableViewCell.reuseIdentifier, for: indexPath)
                commonCell = cell
                
                if let cell = cell as? SegmentControlTableViewCell {
                    cell.model = model
                }
            case .button(model: let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: ButtonTableViewCell.reuseIdentifier, for: indexPath)
                commonCell = cell
                
                if let cell = cell as? ButtonTableViewCell {
                    cell.model = model
                }
            case .colorWell(model: let model):
                let cell = tableView.dequeueReusableCell(withIdentifier: ColorWellTableViewCell.reuseIdentifier, for: indexPath)
                commonCell = cell
                
                if let cell = cell as? ColorWellTableViewCell {
                    cell.model = model
                }
            }
            
            return commonCell
        }
        tableView.register(fromNib: TextFieldTableViewCell.self)
        tableView.register(fromNib: SegmentControlTableViewCell.self)
        tableView.register(fromNib: ButtonTableViewCell.self)
        tableView.register(cell: ColorWellTableViewCell.self)
        tableView.dataSource = adapter
    }
}
