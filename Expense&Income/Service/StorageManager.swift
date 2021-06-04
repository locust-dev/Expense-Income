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
    
    func saveNewUser(profile: UserProfile) {
        write {
            realm.add(profile)
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

// MARK: - Account configure
extension StorageManager {
    func deleteAccount(_ account: Account) {
        write {
            realm.delete(account, cascading: true)
        }
    }
    
    func addAcount(_ account: Account) {
        write {
            self.user.accounts.append(account)
        }
    }
}

// MARK: - Operation configure
extension StorageManager {
    func deleteOperation(_ operation: Operation, _ type: Int, account index: Int) {
        write {
            switch type {
            case 0: user.accounts[index].balance += operation.summ
            default: user.accounts[index].balance -= operation.summ
            }
            realm.delete(operation)
        }
    }
    
    func addOperation(_ operation: Operation, _ type: Int, account index: Int) {
        write {
            switch type {
            case 0:
                let account = user.accounts[index]
                account.expenses.append(operation)
                account.balance -= operation.summ
            default:
                let account = user.accounts[index]
                account.incomes.append(operation)
                account.balance += operation.summ
            }
        }
    }

}
