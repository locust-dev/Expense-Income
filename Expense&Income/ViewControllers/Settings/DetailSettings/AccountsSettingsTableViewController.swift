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
        alert(title: "Редактировать", message: "В разработке")
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
        addAlert(title: "Новый кошелек", message: "Укажите название и начальный баланс")
    }
    
    
}

// MARK: - Private Methods
extension AccountsSettingsTableViewController {
    
    private func insertNewAccount() {
        let cellIndex = IndexPath(row: currentUser.accounts.count - 1, section: 0)
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
    
    private func addAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            guard let balanceString = alert.textFields?.last?.text, !balanceString.isEmpty else { return }
            guard let balance = Int(balanceString) else { return }
            
            let newAccount = Account()
            newAccount.name = name
            newAccount.balance = balance
            
            try! self.realm.write({
                self.realm.objects(UserProfile.self).first?.accounts.append(newAccount)
                self.insertNewAccount()
            })
        }
        alert.addAction(saveAction)
        alert.addTextField { textField in
            textField.placeholder = "Имя кошелька"
        }
        alert.addTextField { textField in
            textField.placeholder = "Баланс"
        }
        
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
}

