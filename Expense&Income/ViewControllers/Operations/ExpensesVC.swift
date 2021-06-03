//
//  ExpensesVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ExpensesVC: UIViewController {
    
    @IBOutlet weak var youSpentLabel: UILabel!
    @IBOutlet weak var remainValue: UILabel!
    @IBOutlet weak var notExpensesYet: UILabel!
    @IBOutlet weak var expenseOrIncomeLabel: UILabel!
    @IBOutlet weak var nameOfAccount: UILabel!
    
    @IBOutlet weak var changeAccount: UIButton!
    @IBOutlet weak var segmented: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tableViewHeight: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var viewAboveLabels: UIView!
    
    var currentUser = StorageManager.shared.user
    private var currentAccount: Account!
    private var currentIndexOfAccount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currentAccount = currentUser.accounts.first
        setBackgroundImage(with: "Back", for: view)
        addShadows(viewAboveLabels)
        setupUI(index: 0)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        setupLabels()
        setupUI(index: segmented.selectedSegmentIndex)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let indexPath = tableView.indexPathForSelectedRow {
            guard let cell = tableView.cellForRow(at: indexPath) as? ExpenseCell else { return }
            guard let detailVC = segue.destination as? DetailVC else { return }
            detailVC.operation = cell.operation
        }
    }
    
    @IBAction func segmented(_ sender: UISegmentedControl) {
        setupLabels()
        tableView.reloadData()
        setupUI(index: sender.selectedSegmentIndex)
    }
    
    @IBAction func changeAccountPressed() {
        currentIndexOfAccount += 1
        if currentIndexOfAccount + 1 > currentUser.accounts.count {
            currentIndexOfAccount = 0
        }
        currentAccount = currentUser.accounts[currentIndexOfAccount]
        setupUI(index: segmented.selectedSegmentIndex)
        setupLabels()
        tableView.reloadData()
    }
    
}

// MARK: - Table View Methods
extension ExpensesVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        convertDatesToString(dates: getAllDates()).count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let date = convertDatesToString(dates: getAllDates())[section]
        var rows = 0
        
        switch segmented.selectedSegmentIndex {
        case 0:
            for expense in currentAccount.expenses {
                let convertedDate = convertDateToString(date: expense.date)
                if convertedDate == date {
                    rows += 1
                }
            }
        default:
            for income in currentAccount.incomes {
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
        
        switch segmented.selectedSegmentIndex {
        case 0:
            for expense in currentAccount.expenses {
                let convertedDate = convertDateToString(date: expense.date)
                if convertedDate == date {
                    operations.append(expense)
                }
            }
        default:
            for income in currentAccount.incomes {
                let convertedDate = convertDateToString(date: income.date)
                if convertedDate == date {
                    operations.append(income)
                }
            }
        }
        
        cell.categoryLabel.text = operations[indexPath.row].category
        cell.expenseLabel.text = "-\(String(operations[indexPath.row].summ)) rub."
        cell.operation = operations[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let datesConverted = convertDatesToString(dates: getAllDates())
        let contentView = UIView()
        let fullNameLabel = UILabel(frame: CGRect(x: 16, y: 6, width: tableView.frame.width, height: 20))
        fullNameLabel.text = datesConverted[section]
        fullNameLabel.font = UIFont.boldSystemFont(ofSize: 17)
        fullNameLabel.textColor = .white
        contentView.addSubview(fullNameLabel)
        return contentView
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let cell = tableView.cellForRow(at: indexPath) as? ExpenseCell else { return }
            guard let operation = cell.operation else { return }
            
            StorageManager.shared.deleteOperation(operation, segmented.selectedSegmentIndex, account: currentIndexOfAccount)
            
            if tableView.numberOfRows(inSection: indexPath.section) == 1 {
                tableView.deleteSections([indexPath.section], with: .automatic)
            } else {
                tableView.deleteRows(at: [indexPath], with: .automatic)
            }
            setupUI(index: segmented.selectedSegmentIndex)
        }
    }
    
}

// MARK: - Private Methods
extension ExpensesVC {
    private func setupUI(index: Int) {
        switch index {
        case 0:
            navigationController?.navigationBar.topItem?.title = "Расходы"
            youSpentLabel.text = "\(String(currentAccount.allExpenses)) руб."
            remainValue.text = "\(String(currentAccount.balance)) руб."
            expenseOrIncomeLabel.text = "Расходы"
        default:
            navigationController?.navigationBar.topItem?.title = "Доходы"
            youSpentLabel.text = "\(String(currentAccount.allIncomes)) руб."
            remainValue.text = "\(String(currentAccount.balance)) руб."
            expenseOrIncomeLabel.text = "Доходы"
        }
        tableViewHeight.constant = view.frame.height-64
        tableView.isScrollEnabled = false
        tableView.bounces = true
    }
    
    private func setupLabels() {
        nameOfAccount.text = currentAccount.name
        var countZero = true
        
        
        switch segmented.selectedSegmentIndex {
        case 0:
            if currentAccount.expenses.count != 0 {
                countZero = false
            }
        default:
            if currentAccount.incomes.count != 0 {
                countZero = false
            }
        }
        
        if countZero {
            notExpensesYet.text = "У вас еще нет ни одной операции, чтобы добавить нажмите + !"
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
        
        switch segmented.selectedSegmentIndex {
        case 0:
            for expense in currentAccount.expenses {
                dates.insert(expense.date)
            }
        default:
            for income in currentAccount.incomes {
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
