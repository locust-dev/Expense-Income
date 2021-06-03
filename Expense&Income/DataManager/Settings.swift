//
//  Settings.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

class Settings {
    static let settingsList = [
        "Настройка категорий",
        "Настройка кошельков"
    ]
}

enum TypeOfSettings: CaseIterable {
    case categories, accounts
}

enum TypeOfOperation: CaseIterable {
    case expense, income
}
