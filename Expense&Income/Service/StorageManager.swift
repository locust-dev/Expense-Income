//
//  StorageManager.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 15.05.2021.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    
    let realm = try! Realm()
    
    private init() {}
    
    func save(profile: UserProfile) {
        try! realm.write {
            realm.add(profile)
        }
    }
    
}
