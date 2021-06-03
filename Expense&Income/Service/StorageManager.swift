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
    
    func deleteOperation(_ operation: Operation, _ type: Int, account index: Int) {
        write {
            switch type {
            case 0: user.accounts[index].balance += operation.summ
            default: user.accounts[index].balance -= operation.summ
            }
            realm.delete(operation)
        }
    }
    
    func write(_ completion: () -> Void) {
        do {
            try realm.write { completion() }
        } catch let error {
            print(error.localizedDescription)
        }
    }
}
