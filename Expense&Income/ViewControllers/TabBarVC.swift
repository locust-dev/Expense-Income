//
//  TabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class TabBarVC: UITabBarController {

    var currentUser = StorageManager.shared.realm.objects(UserProfile.self).first

    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToChild()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let addExpensesVC = segue.source as? AddExpenseVC else { return }
        guard let summ = Int(addExpensesVC.sumTextField.text!) else { return }
        guard let index = addExpensesVC.indexAccountWasChoose else { return }
        
        let newOperation = Operation(
            value: [summ,
                    addExpensesVC.defaultCategory,
                    addExpensesVC.datePicker.date,
                    addExpensesVC.defaultAccount ?? "Not found"])
        
        try! StorageManager.shared.realm.write({
            switch addExpensesVC.operationType {
            case .expense:
                currentUser?.accounts[index].expenses.append(newOperation)
                currentUser?.accounts[index].balance -= summ
            case .income:
                currentUser?.accounts[index].incomes.append(newOperation)
                currentUser?.accounts[index].balance += summ
            }
        })
        
        transferDataToChild()
    }
    
    private func transferDataToChild() {
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            if let navigationVC = viewController as? UINavigationController {
                if let expenseVC = navigationVC.topViewController as? ExpensesVC {
                    expenseVC.currentUser = currentUser
                }
            } else if let budgetVC = viewController as? BudgetVC {
                budgetVC.currentUser = currentUser
            }
        }
    }
    
}
