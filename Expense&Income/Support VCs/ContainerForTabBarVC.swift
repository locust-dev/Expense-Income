//
//  ContainerForTabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ContainerForTabBarVC: UIViewController {
    
    @IBOutlet weak var minusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadiusToCircle(minusButton)
    }

}
