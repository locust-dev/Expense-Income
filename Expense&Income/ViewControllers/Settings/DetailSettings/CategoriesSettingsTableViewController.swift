//
//  CategoriesSettingsVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

import UIKit

class CategoriesSettingsTableViewController: UITableViewController {
    
    var currentUser: UserProfile!
    let sections = ["Категории расходов", "Категории доходов"]
    private let realm = StorageManager.shared.realm
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.contentInset.top = 25
        currentUser = StorageManager.shared.realm.objects(UserProfile.self).first
        setBackgroundForTable("Back", tableView)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return currentUser.expensesCats.count
        default: return currentUser.incomesCats.count
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
    
        switch indexPath.section {
        case 0: cell.textLabel?.text = currentUser.expensesCats[indexPath.row]
        default: cell.textLabel?.text = currentUser.incomesCats[indexPath.row]
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        sections[section]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        editAlert(title: "Редактировать", message: "Как вы хотите изменить категорию?", section: indexPath.section, indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! realm.write({
                switch indexPath.section {
                case 0: realm.objects(UserProfile.self).first?.expensesCats.remove(at: indexPath.row)
                default: realm.objects(UserProfile.self).first?.incomesCats.remove(at: indexPath.row)
                }
            })
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let contentView = UIView()
        let label = UILabel(
            frame: CGRect(
                x: 16,
                y: -6,
                width: tableView.frame.width,
                height: 20
            )
        )
        label.text = sections[section]
        label.font = UIFont(name: "Montserrat", size: 20)
        label.textColor = .white
        
        contentView.addSubview(label)
        return contentView
        
    }
    
    @IBAction func addCategory(_ sender: Any) {
        showAlert(title: "Добавить категорию", message: "Выберите какую категорию вы хотите добавить")
    }
    
}

// MARK: - Private Methods
extension CategoriesSettingsTableViewController {
    
    enum TypeOfAdd {
        case expense, income
    }
    
    private func insertNewCategory(section: Int) {
        var cellIndex = IndexPath()
        
        switch section {
        case 0: cellIndex = IndexPath(row: currentUser.expensesCats.count - 1, section: section)
        default: cellIndex = IndexPath(row: currentUser.incomesCats.count - 1, section: section)
        }
        tableView.insertRows(at: [cellIndex], with: .automatic)
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        let expenseAction = UIAlertAction(title: "Расходы", style: .default) { _ in
            self.addAlert(title: "Добавить новую категорию", message: "", type: .expense)
        }
        let incomeAction = UIAlertAction(title: "Доходы", style: .default) { _ in
            self.addAlert(title: "Добавить новую категорию", message: "", type: .income)
        }
        alert.addAction(expenseAction)
        alert.addAction(incomeAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func addAlert(title: String, message: String, type: TypeOfAdd) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        switch type {
        case .expense:
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                guard let category = alert.textFields?.first?.text, !category.isEmpty else { return }
                try! self.realm.write({
                    self.realm.objects(UserProfile.self).first?.expensesCats.append(category)
                    self.insertNewCategory(section: 0)
                })
            }
            alert.addAction(saveAction)
            alert.addTextField { textField in
                textField.placeholder = "Новая категория расходов"
            }
        case .income:
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                guard let category = alert.textFields?.first?.text, !category.isEmpty else { return }
                try! self.realm.write({
                    self.realm.objects(UserProfile.self).first?.incomesCats.append(category)
                    self.insertNewCategory(section: 1)
                })
            }
            alert.addAction(saveAction)
            alert.addTextField { textField in
                textField.placeholder = "Новая категория доходов"
            }
        }
        
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    private func editAlert(title: String, message: String, section: Int, indexPath: IndexPath) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Отмена", style: .destructive)
        
        switch section {
        case 0:
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                guard let category = alert.textFields?.first?.text, !category.isEmpty else { return }
                try! self.realm.write({
                    self.realm.objects(UserProfile.self).first?.expensesCats[indexPath.row] = category
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                })
            }
            alert.addAction(saveAction)
            alert.addTextField { textField in
                textField.text = self.currentUser.expensesCats[indexPath.row]
            }
        default:
            let saveAction = UIAlertAction(title: "Сохранить", style: .default) { _ in
                guard let category = alert.textFields?.first?.text, !category.isEmpty else { return }
                try! self.realm.write({
                    self.realm.objects(UserProfile.self).first?.incomesCats[indexPath.row] = category
                    self.tableView.reloadRows(at: [indexPath], with: .automatic)
                })
            }
            alert.addAction(saveAction)
            alert.addTextField { textField in
                textField.text = self.currentUser.incomesCats[indexPath.row]
            }
        }
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
}


