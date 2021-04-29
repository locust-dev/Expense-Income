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
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
//    var currentGroup: UserProfile!
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        setBackgroundImage(with: "Back", for: view)
//    }
//
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        navigationController?.navigationBar.topItem?.title = "Доходы"
//        tableView.reloadData()
//        earnedLabel.text = "\(String(currentGroup.allIncomes)) руб."
//
//        heightConstraint.constant = CGFloat(currentGroup.incomes.count) * tableView.rowHeight + 200
//    }
//
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let indexPath = tableView.indexPathForSelectedRow {
//            let detailVC = segue.destination as! DetailVC
//            detailVC.value = currentGroup.incomes[indexPath.row]
//            detailVC.category = currentGroup.catForIncomes[indexPath.row]
//        }
//
//    }
//
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "incomeCell", for: indexPath) as! IncomeCell

        cell.categoryLabel.text = ""
        cell.incomeLabel.text = ""

        return cell
    }

   
}
