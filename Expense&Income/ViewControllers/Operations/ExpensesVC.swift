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
    @IBOutlet weak var expenseOrIncomeLabel: UILabel!
    
    @IBOutlet weak var chooseTableView: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewAboveLabels: UIView!
    
    var currentUser: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setBackgroundImage(with: "Back", for: view)
        addShadows(viewAboveLabels)
        setInitialLabels(index: 0)
        
        tableViewHeight.constant = view.frame.height-64
        tableView.isScrollEnabled = false
        tableView.bounces = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        showNotExpensesYetLabel()
        setInitialLabels(index: chooseTableView.selectedSegmentIndex)
    }
    
    // НЕПРАВИЛЬНО ЭТО ХУЙНЯ ПЕРЕДЕЛЫВАЙ
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            let detailVC = segue.destination as! DetailVC
            detailVC.expense = currentUser.accounts[0].expenses[indexPath.row]
        }
    }
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        tableView.reloadData()
        setInitialLabels(index: sender.selectedSegmentIndex)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        convertDatesToString(dates: getAllDates()).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = convertDatesToString(dates: getAllDates())[section]
        var rows = 0
        
        switch chooseTableView.selectedSegmentIndex {
        case 0:
            for expense in currentUser.accounts[0].expenses {
                let convertedDate = convertDateToString(date: expense.date)
                if convertedDate == date {
                    rows += 1
                }
            }
        default:
            for income in currentUser.accounts[0].incomes {
                let convertedDate = convertDateToString(date: income.date)
                if convertedDate == date {
                    rows += 1
                }
            }
        }
        
        return rows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "expenseCell", for: indexPath) as! ExpenseCell
        let date = convertDatesToString(dates: getAllDates())[indexPath.section]
        var operations: [Operation] = []
        
        switch chooseTableView.selectedSegmentIndex {
        case 0:
            for expense in currentUser.accounts[0].expenses {
                let convertedDate = convertDateToString(date: expense.date)
                if convertedDate == date {
                    operations.append(expense)
                }
            }
        default:
            for income in currentUser.accounts[0].incomes {
                let convertedDate = convertDateToString(date: income.date)
                if convertedDate == date {
                    operations.append(income)
                }
            }
        }
        
        cell.categoryLabel.text = operations[indexPath.row].category
        cell.expenseLabel.text = "-\(String(operations[indexPath.row].summ)) rub."
        
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

// MARK: - Private Methods
extension ExpensesVC {
    private func setInitialLabels(index: Int) {
        switch index {
        case 0:
            navigationController?.navigationBar.topItem?.title = "Расходы"
            youSpentLabel.text = "\(String(currentUser.accounts[0].allExpenses)) руб."
            remainValue.text = "\(String(currentUser.accounts[0].balance)) руб."
            expenseOrIncomeLabel.text = "Расходы"
        default:
            navigationController?.navigationBar.topItem?.title = "Доходы"
            youSpentLabel.text = "\(String(currentUser.accounts[0].allIncomes)) руб."
            remainValue.text = "\(String(currentUser.accounts[0].balance)) руб."
            expenseOrIncomeLabel.text = "Доходы"
        }
    }
    
    private func showNotExpensesYetLabel() {
        var countZero = true
        
        for account in currentUser.accounts {
            if account.expenses.count != 0 {
                countZero = false
                break
            }
        }
        
        if countZero {
            tableView.isHidden = true
            notExpensesYet.isHidden = false
        } else {
            tableView.isHidden = false
            notExpensesYet.isHidden = true
        }
    }
}

// MARK: - Configure Date
extension ExpensesVC {
    
    private func getAllDates() -> [Date] {
        var dates: Set<Date> = []
        var uniqueDatesSorted: [Date] = []
        
        switch chooseTableView.selectedSegmentIndex {
        case 0:
            for expense in currentUser.accounts[0].expenses {
                dates.insert(expense.date)
            }
        default:
            for income in currentUser.accounts[0].incomes {
                dates.insert(income.date)
            }
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

// MARK: - Scroll view delegate
extension ExpensesVC: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView == self.scrollView {
            tableView.isScrollEnabled = (self.scrollView.contentOffset.y >= 200)
        }
        
        if scrollView == self.tableView {
            self.tableView.isScrollEnabled = (tableView.contentOffset.y > 0)
        }
    }
}
