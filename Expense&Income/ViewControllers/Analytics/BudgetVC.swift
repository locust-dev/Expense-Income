//
//  BudgetVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit
import Charts

class BudgetVC: UIViewController {
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var tableView: UITableView!
    
    let currentUser = StorageManager.shared.user
    let currentExpenses = StorageManager.shared.user.accounts.first?.expenses
    var categories = [String]()
    var allSumms = [Double]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundImage(with: "Back", for: view)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Бюджет"
        createCategories()
        createSumms()
        customizeChart(names: categories, values: allSumms)
        tableView.reloadData()
    }
}

//MARK: - Talbe view Configure
extension BudgetVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = categories[indexPath.row]
        cell.detailTextLabel?.text = String(allSumms[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

//MARK: - Configure Pie Chart
extension BudgetVC {
    private func customizeChart(names: [String], values: [Double]) {
        // 1. Set ChartDataEntry
        var dataEntries: [ChartDataEntry] = []
        for index in 0..<names.count {
            let dataEntry = PieChartDataEntry(value: values[index])
            dataEntries.append(dataEntry)
        }
        // 2. Set ChartDataSet
        let pieChartDataSet = PieChartDataSet(entries: dataEntries)
        pieChartDataSet.colors = colorsOfCharts(numbersOfColor: names.count)
        // 3. Set ChartData
        let pieChartData = PieChartData(dataSet: pieChartDataSet)
        let format = NumberFormatter()
        format.numberStyle = .none
        let formatter = DefaultValueFormatter(formatter: format)
        pieChartData.setValueFormatter(formatter)
        // 4. Assign it to the chart’s data
        pieChart.data = pieChartData
        pieChart.holeColor = .clear
        pieChart.drawEntryLabelsEnabled = false
        pieChart.usePercentValuesEnabled = true
        pieChart.legend.enabled = false
        
    }
    
    private func colorsOfCharts(numbersOfColor: Int) -> [UIColor] {
        var colors: [UIColor] = []
        for _ in 0..<numbersOfColor {
            let red = Double.random(in: 120...200)
            let green = 0.0
            let blue = Double.random(in: 120...255)
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        return colors
    }
}

//MARK: - Private methods
extension BudgetVC {
    private func createCategories() {
        var setOfCategories = Set<String>()
        guard let expenses = currentExpenses, !currentExpenses!.isEmpty else { return }
        
        for expense in expenses {
            setOfCategories.insert(expense.category)
        }
        categories = Array(setOfCategories)
    }
    
    private func createSumms() {
        var summs = [Double]()
        var oneCategorySumm = Double()
        guard let expenses = currentExpenses, !currentExpenses!.isEmpty else { return }
        
        for category in categories {
            for expense in expenses {
                if expense.category == category {
                    oneCategorySumm += Double(expense.summ)
                }
            }
            summs.append(oneCategorySumm)
            oneCategorySumm = 0
            
            allSumms = summs
        }
    }
    
}
