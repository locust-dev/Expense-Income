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
        guard let tabBarVC = segue.source as? AddExpenseVC else { return }
        currentGroup.catForExpenses.append(tabBarVC.categoryTextField.text ?? "")
        
        guard let text = Int(tabBarVC.sumTextField.text ?? "") else { return }
        currentGroup.expenses.append(text)
        transferDataToChild()
        
       
        
        
    }
    
    private func transferDataToChild() {
        print(#function)
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
