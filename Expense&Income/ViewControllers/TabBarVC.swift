//
//  TabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class TabBarVC: UITabBarController {

    var currentGroup = UserProfile.getGroup()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToChild()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        guard let addExpensesVC = segue.source as? AddExpenseVC else { return }
            guard let summ = Int(addExpensesVC.sumTextField.text ?? "") else { return }
            
            currentGroup.expenses?.append(Expense(summ: summ,
                                                  category: addExpensesVC.defaultCategory,
                                                  date: Date(timeIntervalSince1970: 100.0),
                                                  account: Account.getAccounts()[0]))
            transferDataToChild()
    
    }
    
    private func transferDataToChild() {
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            if let expenseVC = viewController as? ExpensesVC {
                expenseVC.currentGroup = currentGroup
            } else if let budgetVC = viewController as? BudgetVC {
                budgetVC.currentGroup = currentGroup
            }
        }
    }
    

}
