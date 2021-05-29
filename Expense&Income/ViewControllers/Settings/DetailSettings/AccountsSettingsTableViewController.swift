//
//  AccountsSettingsTableViewController.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

import UIKit

class AccountsSettingsTableViewController: UITableViewController {

    var currentUser: UserProfile!
    private let realm = StorageManager.shared.realm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentUser = StorageManager.shared.realm.objects(UserProfile.self).first
        setBackgroundForTable("Back", tableView)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentUser.accounts.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = currentUser.accounts[indexPath.row].name
        
        return cell
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Мои кошельки"
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        alert(title: "Редактировать", message: "Вы можете изменить имя и баланс кошелька")
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write({
                realm.objects(UserProfile.self).first?.accounts.remove(at: indexPath.row)
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    @IBAction func addAccount(_ sender: Any) {
        
    }
    
    
}


