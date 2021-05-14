//
//  DataManager.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

struct Categories {
    
    var categoriesForExpenses = [
        "Авто",
        "Досуг",
        "Дом",
        "Еда",
        "Благотворительность",
        "Займы",
        "Другое",
        "Коммунальные услуги",
        "Налоги",
        "Одежда и обувь",
        "Подарки",
        "Спорт",
        "Транспорт"
    ]
    
    var categoriesForIncomes = [
        "Авто",
        "Досуг",
        "Дом",
        "Еда",
        "Благотворительность",
        "Займы",
        "Другое",
        "Коммунальные услуги",
        "Налоги",
        "Одежда и обувь",
        "Подарки",
        "Спорт",
        "Транспорт"
    ]
    
    static func getDefautlCategories() -> Categories {
        Categories()
    }
}
