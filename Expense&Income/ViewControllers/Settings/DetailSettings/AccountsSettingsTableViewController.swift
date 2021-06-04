//
//  AccountsSettingsTableViewController.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

import UIKit

class AccountsSettingsTableViewController: UITableViewController {
    
    private let currentUser = StorageManager.shared.user
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 25
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
        editAlert(title: "Редактировать", message: "Вы можете изменить имя и баланс", indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if currentUser.accounts.count == 1 {
                notDeleteAlert(title: "Ошибка!", message: "У вас только один кошелек!")
            } else {
                deleteAlert(title: "Удалить кошелек", message: "Вы уверены?") {
                    StorageManager.shared.deleteAccount(self.currentUser.accounts[indexPath.row])
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let contentView = UIView()
        let label = UILabel(frame: CGRect(x: 16, y: -6, width: tableView.frame.width, height: 20))
        label.text = "Мои кошельки"
        label.font = UIFont(name: "Montserrat", size: 20)
        label.textColor = .white
        contentView.addSubview(label)
        return contentView
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
        
            StorageManager.shared.addAcount(newAccount)
            self.insertNewAccount()
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
    
    private func editAlert(title: String, message: String, indexPath: IndexPath) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            guard let balanceString = alert.textFields?.last?.text, !balanceString.isEmpty else { return }
            guard let balance = Int(balanceString) else { return }
            
            StorageManager.shared.write {
                self.currentUser.accounts[indexPath.row].name = name
                self.currentUser.accounts[indexPath.row].balance = balance
            }
            self.tableView.reloadRows(at: [indexPath], with: .automatic)
        }
        alert.addAction(saveAction)
        alert.addTextField { textField in
            textField.text = self.currentUser.accounts[indexPath.row].name
        }
        alert.addTextField { textField in
            textField.text = String(self.currentUser.accounts[indexPath.row].balance)
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func deleteAlert(title: String, message: String, completion: @escaping () -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        let saveAction = UIAlertAction(title: "Удалить", style: .default) { _ in
            completion()
        }
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func notDeleteAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Ок", style: .destructive)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}
