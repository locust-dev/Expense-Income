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
    
    var operation: Operation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        setBackgroundImage(with: "Back", for: view)
        
        catLabel.text = operation.category
        summLabel.text = String("\(operation.summ) руб.")
        accountLabel.text = operation.account
        
        let df = DateFormatter()
        df.dateFormat = "MMM d, h:mm a"
        dateLabel.text = df.string(from: operation.date)
    }
    
    
}
