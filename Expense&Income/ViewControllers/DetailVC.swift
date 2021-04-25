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
        summLabel.text = String(value)
        navigationController?.navigationBar.tintColor = .white
        setBackgroundImage(with: "Back", for: view)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
