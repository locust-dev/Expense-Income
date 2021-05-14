//
//  ContainerForTabBarVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 23.04.2021.
//

import UIKit

class ContainerForTabBarVC: UIViewController {
    
    var currentUser: UserProfile!
    
    @IBOutlet weak var minusButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setCornerRadiusToCircle(minusButton)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let tabBarVC = segue.destination as? TabBarVC else { return }
        tabBarVC.currentUser = currentUser
    }
}
