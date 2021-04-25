//
//  DetailVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 25.04.2021.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var catLabel: UILabel!
    @IBOutlet weak var summLabel: UILabel!
    
    var value: Int!
    var category: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        catLabel.text = category
        summLabel.text = String("Сумма: \(value ?? 0) руб.")
        navigationController?.navigationBar.tintColor = .white
        setBackgroundImage(with: "Back", for: view)
    }
    
    
}
