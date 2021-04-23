//
//  DataModel.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

struct ExpensesAndIncomes {
    
    let expenses: [Int]!
    let incomes: [Int]!
    let catForExpenses: [String]!
    let catForIncomes: [String]!
    
    var allExpenses: Int {
        var expenses = 0
        
        for expense in self.expenses {
            expenses += expense
        }
        return expenses
    }
    
    var allIncomes: Int {
        var incomes = 0
        
        for income in self.incomes {
            incomes += income
        }
        return incomes
    }
    
    var budget: Int {
        allIncomes - allExpenses
    }
    
    static func getGroup() -> ExpensesAndIncomes {
        ExpensesAndIncomes(expenses: [1000, 500, 777, 300], incomes: [900, 3500, 4200], catForExpenses: ["Машина", "Досуг", "Косметология", "Для дома"], catForIncomes: ["С фриланса", "Майнинг", "Зарплата"])
    }
    
}
