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
    var user: UserProfile {
        realm.objects(UserProfile.self).first!
    }
    
    private init() {}
    
    func save(profile: UserProfile) {
        write {
            realm.add(profile)
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
