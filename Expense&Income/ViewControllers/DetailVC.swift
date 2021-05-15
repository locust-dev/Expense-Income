//
//  DetailVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 25.04.2021.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var summLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var accountLabel: UILabel!
    
    var expense: Expense!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        setBackgroundImage(with: "Back", for: view)
        
        catLabel.text = expense.category
        summLabel.text = String("\(expense.summ) руб.")
        accountLabel.text = expense.account
        
        let df = DateFormatter()
        df.dateFormat = "MMM d, h:mm a"
        dateLabel.text = df.string(from: expense.date)
    }
    
    
}
