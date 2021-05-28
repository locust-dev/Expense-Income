//
//  SettingsVC.swift
//  Expense&Income
//
//  Created by Илья Тюрин on 28.05.2021.
//

import UIKit

class SettingsVC: UITableViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Settings.settingsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "settingsCell", for: indexPath)

        cell.textLabel?.text = Settings.settingsList[indexPath.row]

        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let detailSettingsVC = segue.destination as? DetailSettingsVC else { return }
        guard let index = tableView.indexPathForSelectedRow?.row else { return }
        detailSettingsVC.type = TypeOfSettings.allCases[index]
    }
}
