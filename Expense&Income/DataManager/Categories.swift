//
//  Categories.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import RealmSwift

class Categories {
    
    static let shared = Categories()
    
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
    
    private init() {}
}
