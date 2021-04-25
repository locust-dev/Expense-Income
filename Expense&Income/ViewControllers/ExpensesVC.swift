//
//  ExpensesVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ExpensesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var youSpentLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentGroup: ExpensesAndIncomes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(with: "Back", for: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Расходы"
        tableView.reloadData()
        youSpentLabel.text = "\(String(currentGroup.allExpenses)) руб."

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.value = currentGroup.expenses[indexPath.row]
            detailVC.category = currentGroup.catForExpenses[indexPath.row]
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentGroup.expenses.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        
        cell.categoryLabel.text = currentGroup.catForExpenses[indexPath.row]
        cell.expenseLabel.text = "-\(String(currentGroup.expenses[indexPath.row])) rub."

        return cell
    }

}
