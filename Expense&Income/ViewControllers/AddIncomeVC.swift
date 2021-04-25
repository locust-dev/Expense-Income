//
//  AddIncomeVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class AddIncomeVC: UIViewController, UITextFieldDelegate{
    
    @IBOutlet weak var sumIncomeTexField: UITextField!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    
    var defaultCategory = "Другое"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.tintColor = .white
        setCornerRadiusToCircle(sumIncomeTexField, doneButton, catButton)
        setBackgroundImage(with: "Back", for: view)
        setupGestures()
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
    
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        catButton.addGestureRecognizer(tapGesture)
    }
    
    @objc private func tapped() {
        guard let popVC = storyboard?.instantiateViewController(identifier: "popVC") as? TablePopoverVC else { return }
        popVC.modalPresentationStyle = .popover
        popVC.delegate = self
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.catButton
        popOverVC?.permittedArrowDirections = .up
        popOverVC?.sourceRect = CGRect(x: catButton.bounds.midX - 30, y: catButton.bounds.maxY + 10, width: 0, height: 0)
        
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
    }
   
}

extension AddIncomeVC: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
}

extension AddIncomeVC: AddCategoryDelegate {
    func addCategory(category: String) {
        catButton.setTitle(category, for: .normal)
        defaultCategory = category
    }

}
