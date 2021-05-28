//
//  CategoriesSettingsVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

import UIKit

class DetailSettingsVC: UITableViewController {

    var currentUser: UserProfile!
    var type: TypeOfSettings!
    let sections = ["Категории расходов", "Категории доходов"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = StorageManager.shared.realm.objects(UserProfile.self).first
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        switch type {
        case .categories: return 2
        default: return 1
        }
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch type {
        case .categories:
            switch section {
            case 0: return currentUser.expensesCats.count
            default: return currentUser.incomesCats.count
            }
        default: return currentUser.accounts.count
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath)
        
        switch type {
        case .categories:
            let listForFirst = currentUser.expensesCats
            let listForSecond = currentUser.incomesCats
            switch indexPath.section {
            case 0: cell.textLabel?.text = listForFirst[indexPath.row]
            default: cell.textLabel?.text = listForSecond[indexPath.row]
            }
        default:
            cell.textLabel?.text = currentUser.accounts[indexPath.row].name
        }
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch type {
        case .categories: return sections[section]
        default: return "Мои кошельки"
        }
    }
    
}
