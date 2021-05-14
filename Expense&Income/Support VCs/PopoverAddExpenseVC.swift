//
//  TablePopoverVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 25.04.2021.
//

import UIKit

enum Popover {
    case account
    case categories
}

class PopoverAddExpenseVC: UITableViewController {

    let categories = TabBarVC.userInfo?.categories
    let accounts = TabBarVC.userInfo?.accounts
    var type = Popover.categories
    var delegate: AddInfoDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Back"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .account: return accounts!.count
        case .categories: return categories!.categoriesForExpenses.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! PopoverCell
        
        switch type {
        case .account:
            cell.categoryLabel.text = accounts![indexPath.row].name
        case .categories:
            cell.categoryLabel.text = categories!.categoriesForExpenses[indexPath.row]
        }
        cell.categoryLabel.textColor = .white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PopoverCell
        
        switch type {
        case .account: delegate.addAccount(account: cell.categoryLabel.text ?? "")
        case .categories: delegate.addCategory(category: cell.categoryLabel.text ?? "")
        }
        
        dismiss(animated: true)
    }
    
    
}
