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
    
    var createdUser: UserProfile!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadiusToCircle(nameTF, summTF)
        setBackgroundImage(with: "Back", for: view)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let navigationVC = segue.destination as? UINavigationController else { return }
        guard let containerVC = navigationVC.topViewController as? ContainerForTabBarVC else { return }
        containerVC.currentUser = createdUser
    }

    @IBAction func createUser(_ sender: Any) {
        guard let summ = summTF.text, let name = nameTF.text else {
            alert(title: "Ошибка!", message: "Не оставляйте поля пустыми!")
            return
        }
        guard let balance = Int(summ) else { return }
        createdUser = UserProfile(accounts: [], categories: Categories.getDefautlCategories())
        createdUser.accounts?.append(
            Account(name: name,
                    balance: balance,
                    expenses: [],
                    incomes: []))
        
        performSegue(withIdentifier: "toTabBarVC", sender: nil)
    }
    
    
}
