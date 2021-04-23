//
//  UIViewController.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

extension UIViewController {
    
    func setCornerRadiusToCircle(_ button: UIButton...) {
        button.forEach{ button in
            button.layer.cornerRadius = button.frame.height / 2
        }
    }
    
}
