//
//  ConsumptionListViewController.swift
//  CashStats
//
//  Created by GGsrvg on 27.06.2021.
//

import UIKit
import LDS

class ConsumptionListViewController: BaseViewController<ConsumptionListViewModel> {
    
    var adapter: UITableViewAdapter<String, ConsumptionPresenter, String?>!
    
    @IBOutlet weak var tableView: UITableView!
    
    deinit {
        adapter?.observableDataSource = nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        adapter = .init(tableView)
        adapter.observableDataSource = viewModel.сonsumptions
        adapter.titleForHeaderSectionHandler = { [weak self] tableView, section in
            guard let self = self else { return nil }
            return self.viewModel.сonsumptions.array[section].header
        }
        adapter.cellForRowHandler = { tableView, indexPath, model in
            let cell = tableView.dequeueReusableCell(withIdentifier: ConsumptionTableViewCell.reuseIdentifier, for: indexPath)
            
            return cell
        }
        tableView.register(fromNib: ConsumptionTableViewCell.self)
        tableView.dataSource = adapter
        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
