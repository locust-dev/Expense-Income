//
//  BudgetVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class BudgetVC: UIViewController {
    
    @IBOutlet weak var budgetValue: UILabel!
    
    var currentGroup: ExpensesAndIncomes!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Budget"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        budgetValue.text = String(currentGroup.budget)
    }
   
    
}
