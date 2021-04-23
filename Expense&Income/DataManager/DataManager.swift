//
//  DataManager.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

struct ExpensesAndIncomes {
    
    let expenses: [Int]!
    let incomes: [Int]!
    let catForExpenses: [String]!
    let catForIncomes: [String]!
    
    static func getGroup() -> ExpensesAndIncomes {
        ExpensesAndIncomes(expenses: [0], incomes: [0], catForExpenses: ["Пока что, у вас нет добавленных расходов!"], catForIncomes: ["Пока что, у вас нет добавленных доходов!"])
    }
    
}
