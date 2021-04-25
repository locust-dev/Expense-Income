//
//  DataModel.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

struct ExpensesAndIncomes {
    
    var expenses: [Int]!
    var incomes: [Int]!
    var catForExpenses: [String]!
    var catForIncomes: [String]!
    
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
        ExpensesAndIncomes(expenses: [1000, 500, 777, 300, 100], incomes: [900, 3500, 4200, 300, 400], catForExpenses: ["Машина", "Лекарства", "Косметология", "Для дома", "Хотелки"], catForIncomes: ["С фриланса", "Долг", "Зарплата", "Другое", "Депозит"])
    }
    
}
