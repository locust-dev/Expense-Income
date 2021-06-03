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

class AddExpenseVC: UIViewController {
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var cancel: UIButton!
    @IBOutlet weak var catButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    
    @IBOutlet weak var segment: UISegmentedControl!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var sumTextField: UITextField!
    
    let currentUser = StorageManager.shared.user
    var defaultCategory = "Другое"
    var defaultAccount: String?
    var indexAccountWasChoose = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        defaultAccount = currentUser.accounts.first?.name
        setupUI()
        setupGestures()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super .touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func addNewOperationPressed() {
        addNewOperation()
        dismiss(animated: true)
    }
    
    @IBAction func cancelButton() {
        dismiss(animated: true)
    }
    
}

// MARK: - Private methods
extension AddExpenseVC {
    private func addNewOperation() {
        guard let summ = sumTextField.text, !sumTextField.text!.isEmpty else {
            alert(title: "Ошибка", message: "Пожалуйста, заполните сумму!")
            return
        }
        guard let summInt = Int(summ) else {
            alert(title: "Ошибка", message: "Используйте только цифры 0-9")
            return
        }
        
        let newOperation = Operation()
        newOperation.summ = summInt
        newOperation.account = defaultAccount ?? "Not found"
        newOperation.category = defaultCategory
        newOperation.date = datePicker.date
        
        StorageManager.shared.write {
            switch segment.selectedSegmentIndex {
            case 0:
                let account = currentUser.accounts[indexAccountWasChoose]
                account.expenses.append(newOperation)
                account.balance -= summInt
            default:
                let account = currentUser.accounts[indexAccountWasChoose]
                account.incomes.append(newOperation)
                account.balance += summInt
            }
        }
    }
    
    private func setupUI() {
        catButton.setTitle(defaultCategory, for: .normal)
        accountButton.setTitle(defaultAccount, for: .normal)
        setCornerRadiusToCircle(sumTextField, doneButton, catButton, accountButton, cancel)
        setBackgroundImage(with: "Back", for: view)
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
    
    @objc private func tappedCat(button: UIButton) {
        createPopoverFrom(button: catButton)
    }
    
    @objc private func tappedAccount() {
        createPopoverFrom(button: accountButton)
    }
    
    private func createPopoverFrom(button: UIButton) {
        guard let popVC = storyboard?.instantiateViewController(identifier: "popVC") as? PopoverAddExpenseVC else { return }
        popVC.modalPresentationStyle = .popover
        popVC.delegate = self
        
        let popOverVC = popVC.popoverPresentationController
        popOverVC?.delegate = self
        popOverVC?.permittedArrowDirections = .up
        
        if button == catButton {
            popVC.type = Popover.categories
            popOverVC?.sourceView = catButton
            popOverVC?.sourceRect = CGRect(x: catButton.bounds.midX - 30, y: catButton.bounds.maxY + 10, width: 0, height: 0)
        } else {
            popVC.type = Popover.account
            popOverVC?.sourceView = accountButton
            popOverVC?.sourceRect = CGRect(x: accountButton.bounds.midX - 30, y: accountButton.bounds.maxY + 10, width: 0, height: 0)
        }
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
