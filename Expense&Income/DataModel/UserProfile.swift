//
//  UserProfile.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import RealmSwift

class UserProfile: Object {
    var expensesCats = List<String>()
    var incomesCats = List<String>()
    var accounts = List<Account>()
}

class Account: Object {
    @objc dynamic var name = "Новый кошелек"
    @objc dynamic var balance = 0
    var expenses = List<Operation>()
    var incomes = List<Operation>()
    
    var allExpenses: Int {
        var allExpenses = 0
        
        for expense in self.expenses {
            allExpenses += expense.summ
        }
        return allExpenses
    }
}

class Operation: Object {
    @objc dynamic var summ = 0
    @objc dynamic var category = ""
    @objc dynamic var date = Date()
    @objc dynamic var account = ""
}
