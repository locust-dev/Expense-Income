//
//  ExpensesVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ExpensesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var youSpentLabel: UILabel!
    @IBOutlet weak var remainValue: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    @IBOutlet weak var viewAboveLabels: UIView!
    
    var currentGroup: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(with: "Back", for: view)
        addShadows(viewAboveLabels)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Расходы"
        tableView.reloadData()
        
        youSpentLabel.text = "\(String(currentGroup.allExpenses)) руб."
        remainValue.text = "\(String(currentGroup.budget)) руб."
        
        heightConstraint.constant = CGFloat(currentGroup.expenses?.count ?? 1) * tableView.rowHeight + 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.value = currentGroup.expenses?[indexPath.row].summ
            detailVC.category = currentGroup.expenses?[indexPath.row].category
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentGroup.expenses?.count ?? 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        
        cell.categoryLabel.text = currentGroup.expenses?[indexPath.row].category
        cell.expenseLabel.text = "-\(String(currentGroup.expenses?[indexPath.row].summ ?? 0)) rub."

        return cell
    }

}
