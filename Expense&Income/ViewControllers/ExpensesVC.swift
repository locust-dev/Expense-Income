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
        
        //heightConstraint.constant = CGFloat(currentGroup.expenses?.count ?? 1) * tableView.rowHeight + 200
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.value = currentGroup.expenses?[indexPath.row].summ
            detailVC.category = currentGroup.expenses?[indexPath.row].category
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        getAllDates().count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = getAllDates()[section]
        var rows = 0
        
        for expense in currentGroup.expenses! {
            if expense.date == date {
                rows += 1
            }
        }
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        let date = getAllDates()[indexPath.section]
        var expenses: [Expense] = []
        
        for expense in currentGroup.expenses! {
            if expense.date == date {
                expenses.append(expense)
            }
        }
        
        cell.categoryLabel.text = expenses[indexPath.row].category
        cell.expenseLabel.text = "-\(String(expenses[indexPath.row].summ ?? 0)) rub."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let dates = getAllDates()
        let datesConverted = convertDateToString(dates: dates)
        
        let contentView = UIView()
        let fullNameLabel = UILabel(
            frame: CGRect(
                x: 16,
                y: 6,
                width: tableView.frame.width,
                height: 20
            )
        )
        fullNameLabel.text = datesConverted[section]
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        fullNameLabel.textColor = .white
        
        contentView.addSubview(fullNameLabel)
        return contentView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }
}

// MARK: - Configure Date
extension ExpensesVC {
    
    private func getAllDates() -> [Date] {
        var dates: Set<Date> = []
        var uniqueDatesSorted: [Date] = []
        
        for expense in currentGroup.expenses! {
            dates.insert(expense.date!)
        }
        uniqueDatesSorted = Array(dates)
        uniqueDatesSorted.sort(by: >)
        return uniqueDatesSorted
    }
    
    private func convertDateToString(dates: [Date]) -> [String] {
        var datesConverted: [String] = []
        
        for date in dates {
            let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM d, Y"
            let dateNow = Calendar.current.date(from: dateComponents)
            datesConverted.append(dateFormatter.string(from: dateNow!))
        }
        datesConverted.sort(by: >)
        return datesConverted
    }
    
}
