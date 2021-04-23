//
//  ExpensesVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ExpensesVC: UITableViewController {

    var currentGroup: ExpensesAndIncomes!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        navigationController?.navigationBar.topItem?.title = "Expenses"

    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentGroup.expenses.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell

        cell.categoryLabel.text = currentGroup.catForExpenses[indexPath.row]
        cell.expenseLabel.text = String(currentGroup.expenses[indexPath.row])

        return cell
    }

}
