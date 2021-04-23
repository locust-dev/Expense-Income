//
//  IncomesVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class IncomesVC: UITableViewController {

    var currentGroup: ExpensesAndIncomes!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.topItem?.title = "Incomes"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentGroup.incomes.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! IncomeCell
        
        cell.categoryLabel.text = currentGroup.catForIncomes[indexPath.row]
        cell.incomeLabel.text = String(currentGroup.incomes[indexPath.row])

        return cell
    }

   
}
