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
    
    @IBAction func createUser(_ sender: Any) {
        
        if summTF.text == "" || nameTF.text == "" {
            alert(title: "Ошибка!", message: "Пожалуйста, укажите начальный баланс и имя кошелька!")
            return
        }
        
        guard let summ = summTF.text else { return }
        guard let name = nameTF.text else { return }
        guard let balance = Int(summ) else {
            alert(title: "Ошибка!", message: "В строке баланса должны быть только цифры 0-9 без символов")
            return
        }
        
        let createdUser = UserProfile()
        let account = Account()
        account.balance = balance
        account.name = name
            
        createdUser.accounts.append(account)
        createdUser.expensesCats.append(objectsIn: DefaultCategories.categoriesForExpenses)
        createdUser.incomesCats.append(objectsIn: DefaultCategories.categoriesForIncomes)
        StorageManager.shared.saveNewUser(profile: createdUser)
        
        performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }
    
    
}
