//
//  DataModel.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import Foundation

struct UserProfile {
    
    var expenses: [Expense]?
    var incomes: [Income]?
    var accounts: [Account]?
    
    
    var allExpenses: Int {
        var expenses = 0
        
        for expense in self.expenses ?? [] {
            expenses += expense.summ ?? 0
        }
        return expenses
    }

    var allIncomes: Int {
        var incomes = 0

        for income in self.incomes ?? [] {
            incomes += income.summ ?? 0
        }
        return incomes
    }

    var budget: Int {
        (accounts?[0].balance)! - allExpenses
    }
    
    static func getGroup() -> UserProfile {
        UserProfile(expenses: Expense.getExpenses(),
                    incomes: Income.getIncomes(),
                    accounts: Account.getAccounts())
    }
    
}


struct Expense {
    var summ: Int?
    var category: String?
    var date: Date?
    var account: Account?
    
    static func getExpenses() -> [Expense] {
        let categories = Categories()
        var expenses: [Expense] = []
        
        for _ in 1...5 {
            expenses.append(Expense(summ: Int.random(in: 500...4000),
                                    category: categories.categoriesForExpenses.randomElement(),
                                    date: Date(timeIntervalSince1970: 100.0),
                                    account: Account.getAccounts()[0]))
        }
        return expenses
    }
}

struct Income {
    var summ: Int?
    var category: String?
    var date: Date?
    var account: Account?
    
    static func getIncomes() -> [Income] {
        let categories = Categories()
        var incomes: [Income] = []
        
        for _ in 1...5 {
            incomes.append(Income(summ: Int.random(in: 500...4000),
                                    category: categories.categoriesForIncomes.randomElement(),
                                    date: Date(timeIntervalSince1970: 100.0),
                                    account: Account.getAccounts()[0]))
        }
        return incomes
    }
}

struct Account {
    var name: String?
    var balance: Int?
    
    static func getAccounts() -> [Account] {
        [Account(name: "Банковская карта", balance: 65000)]
    }
    
    
}
