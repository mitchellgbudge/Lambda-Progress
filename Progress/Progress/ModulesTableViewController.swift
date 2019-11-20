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
        moduleController.decodeJSON()
        self.tableView.reloadData()
    }
    


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var header = ""
        switch section {
        case 0: header = "Swift Fundamentals"
        default:
            break
        }
        return header
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moduleController.modules.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ModuleCell", for: indexPath) as? ModuleTableViewCell else { return UITableViewCell() }
        let module = moduleController.modules[indexPath.row]
        cell.moduleNameLabel.text = module.name
        cell.masteryPercentageLabel.text = "\(Int(module.mastery ?? 0))% mastered"
        return cell
    }

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowModule" {
            guard let destinationVC = segue.destination as? ModuleDetailViewController,
                let indexPath = tableView.indexPathForSelectedRow else { return }
            destinationVC.module = moduleController.modules[indexPath.row]
            destinationVC.moduleController = moduleController
        }
    }

}
