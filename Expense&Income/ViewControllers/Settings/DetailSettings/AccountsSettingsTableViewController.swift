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
        editAlert(title: "Редактировать", message: "Вы можете изменить имя и баланс", rowIndex: indexPath.row)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            if currentUser.accounts.count == 1 {
                notDeleteAlert(title: "Ошибка!", message: "У вас только один кошелек!")
            } else {
                deleteAlert(title: "Удалить кошелек", message: "Вы уверены?") { [self] in
                    try! realm.write({
                        realm.objects(UserProfile.self).first?.accounts.remove(at: indexPath.row)
                    })
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
    
    private func editAlert(title: String, message: String, rowIndex: Int) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
            guard let name = alert.textFields?.first?.text, !name.isEmpty else { return }
            guard let balanceString = alert.textFields?.last?.text, !balanceString.isEmpty else { return }
            guard let balance = Int(balanceString) else { return }
            
            try! self.realm.write({
                StorageManager.shared.user.accounts[rowIndex].name = name
                StorageManager.shared.user.accounts[rowIndex].balance = balance
            })
        }
        alert.addAction(saveAction)
        alert.addTextField { textField in
            textField.text = self.currentUser.accounts[rowIndex].name
        }
        alert.addTextField { textField in
            textField.text = String(self.currentUser.accounts[rowIndex].balance)
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
