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
    @IBOutlet weak var notExpensesYet: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewAboveLabels: UIView!
    
    var currentUser: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(with: "Back", for: view)
        addShadows(viewAboveLabels)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Расходы"
        tableView.reloadData()
        youSpentLabel.text = "\(String(currentUser.accounts[0].allExpenses)) руб."
        remainValue.text = "\(String(currentUser.accounts[0].balance)) руб."
    
        if currentUser.accounts[0].expenses.count == 0 {
            tableView.isHidden = true
            notExpensesYet.isHidden = false
        } else {
            tableView.isHidden = false
            notExpensesYet.isHidden = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let section = tableView.indexPathForSelectedRow?.section else { return }
        
        
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.expense = currentUser.accounts[0].expenses[indexPath.row]
        }
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        convertDatesToString(dates: getAllDates()).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = convertDatesToString(dates: getAllDates())[section]
        var rows = 0
        
        for expense in currentUser.accounts[0].expenses {
            let convertedDate = convertDateToString(date: expense.date)
            if convertedDate == date {
                rows += 1
            }
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        let date = convertDatesToString(dates: getAllDates())[indexPath.section]
        var expenses: [Expense] = []
        
        for expense in currentUser.accounts[0].expenses {
            let convertedDate = convertDateToString(date: expense.date)
            if convertedDate == date {
                expenses.append(expense)
            }
        }
    
        cell.categoryLabel.text = expenses[indexPath.row].category
        cell.expenseLabel.text = "-\(String(expenses[indexPath.row].summ)) rub."
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let datesConverted = convertDatesToString(dates: getAllDates())
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
        
        for expense in currentUser.accounts[0].expenses {
            dates.insert(expense.date)
        }
        uniqueDatesSorted = Array(dates)
        uniqueDatesSorted.sort(by: >)
        return uniqueDatesSorted
    }
    
    private func convertDatesToString(dates: [Date]) -> [String] {
        var datesConverted: [String] = []
        
        for date in dates {
            datesConverted.append(convertDateToString(date: date))
        }
        
        let sortedArray = datesConverted.removingDuplicates()
        return sortedArray
    }
    
    private func convertDateToString(date: Date) -> String {
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day], from: date)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, Y"
        let dateNow = Calendar.current.date(from: dateComponents)
        return dateFormatter.string(from: dateNow!)
    }
}
