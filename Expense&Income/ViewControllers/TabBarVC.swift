//
//  TabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class TabBarVC: UITabBarController {

    var currentGroup = ExpensesAndIncomes.getGroup()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToChild()
    }
    
    @IBAction func unwind(for segue: UIStoryboardSegue) {
        if let addExpensesVC = segue.source as? AddExpenseVC {
            currentGroup.catForExpenses.append(addExpensesVC.defaultCategory)
            guard let text = Int(addExpensesVC.sumTextField.text ?? "") else { return }
            currentGroup.expenses.append(text)
            transferDataToChild()
        } else {
            guard let addIncomeVC = segue.source as? AddIncomeVC else { return }
            currentGroup.catForIncomes.append(addIncomeVC.defaultCategory)
            guard let text = Int(addIncomeVC.sumIncomeTexField.text ?? "") else { return }
            currentGroup.incomes.append(text)
            transferDataToChild()
        }
    }
    
    private func transferDataToChild() {
        guard let viewControllers = self.viewControllers else { return }
        
        for viewController in viewControllers {
            if let expenseVC = viewController as? ExpensesVC {
                expenseVC.currentGroup = currentGroup
            } else if let incomesVC = viewController as? IncomesVC {
                incomesVC.currentGroup = currentGroup
            } else if let budgetVC = viewController as? BudgetVC {
                budgetVC.currentGroup = currentGroup
            }
        }
    }
    

}
