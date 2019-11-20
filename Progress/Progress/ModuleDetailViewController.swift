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
    var module: Module? {
        didSet {
            updateViews()
        }
    }
    var moduleController: ModuleController?
    
    @IBOutlet weak var tableView: UITableView!
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
    
    @IBAction func updateConfidence(_ confidenceControl: StarRating) {
        guard let module = module else { return }
        switch confidenceControl.value {
        case 2:
            module.confidence = 2
        case 3:
            module.confidence = 3
        default:
            module.confidence = 1
        }
    }
    
    @IBAction func updateRating(_ ratingControl: StarRating) {
        guard let module = module else { return }
        switch ratingControl.value {
        case 2:
            module.rating = 2
        case 3:
            module.rating = 3
        default:
            module.rating = 1
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
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
