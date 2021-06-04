//
//  ExpenseCell.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ExpenseCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var expenseLabel: UILabel!
    
    var operation: Operation?
    
}
