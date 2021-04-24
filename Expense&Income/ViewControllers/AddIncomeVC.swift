//
//  AddIncomeVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class AddIncomeVC: UIViewController, UITextFieldDelegate{

    @IBOutlet weak var categoryIncomeTextField: UITextField!
    @IBOutlet weak var sumIncomeTexField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        sumIncomeTexField.delegate = self
      
    }
    

    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == sumIncomeTexField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
   
}
