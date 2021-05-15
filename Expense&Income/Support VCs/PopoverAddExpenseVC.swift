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

    var userProfile: UserProfile!
    var type = Popover.categories
    var delegate: AddInfoDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundView = UIImageView(image: UIImage(named: "Back"))
        userProfile = StorageManager.shared.realm.objects(UserProfile.self).first
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .account: return userProfile.accounts.count
        case .categories: return userProfile.expensesCats.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! PopoverCell
        
        switch type {
        case .account:
            cell.categoryLabel.text = userProfile.accounts[indexPath.row].name
        case .categories:
            cell.categoryLabel.text = userProfile.expensesCats[indexPath.row]
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
