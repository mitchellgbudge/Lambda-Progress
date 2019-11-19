//
//  ModulesTableViewController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class ModulesTableViewController: UITableViewController {

    // MARK: - Properties
    let moduleController = ModuleController()
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleController.modules.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleCell", for: indexPath) as? ModuleTableViewCell else { return UITableViewCell() }
        let module = moduleController.modules[indexPath.row]
        cell.moduleNameLabel.text = module.name
        if module.mastery == true {
            cell.masteryPercentageLabel.text = "100% mastered"
        } else {
            cell.masteryPercentageLabel.text = "0% mastered"
        }
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      
    }

}
