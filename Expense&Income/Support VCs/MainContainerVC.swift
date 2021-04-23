//
//  MainContainerVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class MainContainerVC: UIViewController {
    
    @IBOutlet weak var minusButton: UIButton!
    @IBOutlet weak var plusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCornerRadiusToCircle(
            minusButton,
            plusButton
        )
    }
    
    
    
}
