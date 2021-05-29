//
//  SettingsVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

import UIKit

class SettingsVC: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setBackgroundForTable("Back", tableView)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Settings.settingsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)
        cell.textLabel?.text = Settings.settingsList[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let settingCase = TypeOfSettings.allCases[indexPath.row]
        switch settingCase {
        case .categories: performSegue(withIdentifier: "toCategories", sender: nil)
        case .accounts: performSegue(withIdentifier: "toAccounts", sender: nil)
        }
    }
    
}
