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
        guard let summ = Int(addExpensesVC.sumTextField.text ?? "") else { return }
        
        let newExpense = Expense(
            value: [summ,
                    addExpensesVC.defaultCategory,
                    addExpensesVC.datePicker.date,
                    addExpensesVC.defaultAccount])
        
        try! StorageManager.shared.realm.write({
            let user = StorageManager.shared.realm.objects(UserProfile.self)[0].accounts[0]
            user.expenses.append(newExpense)
            user.balance -= summ
        })
        
        transferDataToChild()
    }
    
    private func transferDataToChild() {
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            if let expenseVC = viewController as? ExpensesVC {
                expenseVC.currentUser = currentUser
            } else if let budgetVC = viewController as? BudgetVC {
                budgetVC.currentUser = currentUser
            }
        }
    }
    
}
