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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
