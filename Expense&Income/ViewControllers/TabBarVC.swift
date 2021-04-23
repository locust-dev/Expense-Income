//
//  TabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class TabBarVC: UITabBarController {

    let currentGroup = ExpensesAndIncomes.getGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        transferDataToChild()
    }
    
    private func transferDataToChild() {
        let expensesVC = viewControllers?.first as! ExpensesVC
        let incomesVC = viewControllers?.last as! IncomesVC
        
        expensesVC.currentGroup = currentGroup
        incomesVC.currentGroup = currentGroup
    }
    

}
