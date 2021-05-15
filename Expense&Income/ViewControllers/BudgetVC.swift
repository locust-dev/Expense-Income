//
//  BudgetVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class BudgetVC: UIViewController {
    
    @IBOutlet weak var budgetValue: UILabel!
    
    var currentUser: UserProfile!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Бюджет"
        budgetValue.text = "\(String(currentUser.accounts[0].balance)) руб."
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(with: "Back", for: view)
    }

    
    
    
    
}
