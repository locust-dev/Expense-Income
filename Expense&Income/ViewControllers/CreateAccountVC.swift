//
//  CreateAccountVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 13.05.2021.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var summTF: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCornerRadiusToCircle(nameTF, summTF)
        setBackgroundImage(with: "Back", for: view)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }

    
    @IBAction func go(_ sender: Any) {
        performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }
    
    @IBAction func createUser(_ sender: Any) {
        guard let summ = summTF.text, let name = nameTF.text else { return }
        guard let balance = Int(summ) else { return }
        
        let createdUser = UserProfile()
        let defaultCats = Categories()
        let account = Account()
        account.balance = balance
        account.name = name
            
        createdUser.accounts.append(account)
        createdUser.expensesCats.append(objectsIn: defaultCats.categoriesForExpenses)
        createdUser.incomesCats.append(objectsIn: defaultCats.categoriesForIncomes)
        StorageManager.shared.save(profile: createdUser)
        
        performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }
    
    
}
