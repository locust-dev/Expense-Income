//
//  AddExpenseVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

protocol AddInfoDelegate {
    func addCategory(category: String)
    func addAccount(account: String, index: Int)
}

enum OperationType {
    case expense
    case income
}

class AddExpenseVC: UIViewController {
    
    @IBOutlet weak var sumTextField: UITextField!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    
    @IBOutlet weak var segment: UISegmentedControl!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    
    let currentUser = StorageManager.shared.realm.objects(UserProfile.self).first
    var operationType = OperationType.expense
    var defaultCategory = "Другое"
    var defaultAccount: String?
    var indexAccountWasChoose: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.tintColor = .white
        setCornerRadiusToCircle(sumTextField, doneButton, catButton, accountButton)
        setBackgroundImage(with: "Back", for: view)
        
        defaultAccount = currentUser?.accounts[0].name
        catButton.setTitle(defaultCategory, for: .normal)
        accountButton.setTitle(defaultAccount, for: .normal)
        
        setupGestures()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func changeOperationType(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: operationType = .expense
        default: operationType = .income
        }
    }
}

// MARK: - TextField Delegate
extension AddExpenseVC: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField == sumTextField {
            let allowedCharacters = CharacterSet(charactersIn:"0123456789")
            let characterSet = CharacterSet(charactersIn: string)
            return allowedCharacters.isSuperset(of: characterSet)
        }
        return true
    }
}

// MARK: - Configure Popover
extension AddExpenseVC: UIPopoverPresentationControllerDelegate {
    
    internal func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    private func setupGestures() {
        let tapCat = UITapGestureRecognizer(target: self, action: #selector(tappedCat))
        let tapAccount = UITapGestureRecognizer(target: self, action: #selector(tappedAccount))
        tapCat.numberOfTapsRequired = 1
        tapAccount.numberOfTapsRequired = 1
        catButton.addGestureRecognizer(tapCat)
        accountButton.addGestureRecognizer(tapAccount)
    }
    
    @objc private func tappedCat() {
        guard let popVC = storyboard?.instantiateViewController(identifier: "popVC") as? PopoverAddExpenseVC else { return }
        popVC.modalPresentationStyle = .popover
        popVC.delegate = self
        popVC.type = Popover.categories
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.catButton
        popOverVC?.permittedArrowDirections = .up
        popOverVC?.sourceRect = CGRect(x: catButton.bounds.midX - 30, y: catButton.bounds.maxY + 10, width: 0, height: 0)
        
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
    }
    
    @objc private func tappedAccount() {
        guard let popVC = storyboard?.instantiateViewController(identifier: "popVC") as? PopoverAddExpenseVC else { return }
        popVC.modalPresentationStyle = .popover
        popVC.delegate = self
        popVC.type = Popover.account
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.sourceView = self.accountButton
        popOverVC?.permittedArrowDirections = .up
        popOverVC?.sourceRect = CGRect(x: accountButton.bounds.midX - 30, y: accountButton.bounds.maxY + 10, width: 0, height: 0)
        
        popVC.preferredContentSize = CGSize(width: 250, height: 250)
        self.present(popVC, animated: true)
    }
}

// MARK: - Delegate
extension AddExpenseVC: AddInfoDelegate {
    func addAccount(account: String, index: Int) {
        accountButton.setTitle(account, for: .normal)
        indexAccountWasChoose = index
        defaultAccount = account
    }
    
    func addCategory(category: String) {
        catButton.setTitle(category, for: .normal)
        defaultCategory = category
    }
}
