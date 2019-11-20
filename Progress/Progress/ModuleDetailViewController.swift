//
//  ModuleDetailViewController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class ModuleDetailViewController: UIViewController {
    
    // MARK: - Properties & outlets
    var module: ModuleRepresentation? {
        didSet {
            updateViews()
        }
    }
    var moduleController: ModuleController?
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var guidedStarsButton: UIButton!
    @IBOutlet weak var afternoonStarsButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
    }
    
    // MARK: - Actions
    
    func updateViews() {
        guard isViewLoaded,
            let module = module else { return }
        self.title = module.name
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
    
    
    
}

extension ModuleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let module = module,
            let objectives = module.objectives else { return 0 }
        return objectives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectiveCell", for: indexPath) as? ObjectiveTableViewCell
            else { return UITableViewCell() }
        guard let module = module,
            let objectives = module.objectives else { return UITableViewCell() }
        let objective = objectives[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.objectiveLabel.text = objective
        return cell
    }
}
