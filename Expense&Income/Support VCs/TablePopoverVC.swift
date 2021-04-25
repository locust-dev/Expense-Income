//
//  TablePopoverVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 25.04.2021.
//

import UIKit

class TablePopoverVC: UITableViewController {

    let categories = Categories()
    var delegate: AddCategoryDelegate!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundView = UIImageView(image: UIImage(named: "Back"))
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.allCategories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "catCell", for: indexPath) as! PopoverCell
        
        cell.categoryLabel.text = categories.allCategories[indexPath.row]
        cell.categoryLabel.textColor = .white
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! PopoverCell
        delegate.addCategory(category: cell.categoryLabel.text ?? "")
        dismiss(animated: true)
        
    }
    
    
}
