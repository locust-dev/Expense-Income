//
//  TabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class TabBarVC: UITabBarController {

    var currentUser: UserProfile!
    static var userInfo: UserProfile?
   
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToChild()
        TabBarVC.userInfo = currentUser
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let addExpensesVC = segue.source as? AddExpenseVC else { return }
        guard let summ = Int(addExpensesVC.sumTextField.text ?? "") else { return }
        
        currentUser
            .accounts![0]
            .balance -= summ
        
        currentUser
            .accounts![0]
            .expenses?
            .append(Expense(summ: summ,
                            category: addExpensesVC.defaultCategory,
                            date: addExpensesVC.datePicker.date,
                            account: addExpensesVC.defaultAccount))
        
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
