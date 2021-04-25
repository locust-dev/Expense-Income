//
//  IncomesVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class IncomesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var earnedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var currentGroup: ExpensesAndIncomes!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(with: "Back", for: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Доходы"
        tableView.reloadData()
        earnedLabel.text = "\(String(currentGroup.allIncomes)) руб."
    }

    // MARK: - Table view data source

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        currentGroup.incomes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! IncomeCell
        
        cell.categoryLabel.text = currentGroup.catForIncomes[indexPath.row]
        cell.incomeLabel.text = "+\(String(currentGroup.incomes[indexPath.row])) rub."

        return cell
    }

   
}
