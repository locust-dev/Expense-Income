//
//  DataModel.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import Foundation

struct UserProfile {
    var accounts: [Account]?
    var categories = Categories()
}

struct Account {
    var name = "Новый кошелек"
    var balance = 0
    var expenses: [Expense]?
    var incomes: [Income]?
    
    var allExpenses: Int {
        var allExpenses = 0
        
        for expense in self.expenses ?? [] {
            allExpenses += expense.summ ?? 0
        }
        return allExpenses
    }
}

struct Expense {
    var summ: Int?
    var category: String?
    var date: Date?
    var account: String?
}

struct Income {
    var summ: Int?
    var category: String?
    var date: Date?
    var account: String?
}


