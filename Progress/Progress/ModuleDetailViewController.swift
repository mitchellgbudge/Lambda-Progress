//
//  ModuleDetailViewController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class ModuleDetailViewController: UIViewController, ObjectiveTableViewCellDelegate {
    
    // MARK: - Properties & outlets
    var module: Module? {
        didSet {
            updateViews()
        }
    }
    var moduleController: ModuleController?
    var arithmetic: Double = 0
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var guidedProjectStars: StarRating!
    @IBOutlet weak var afternoonProjectStars: StarRating!
    
    
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTheme()
        updateViews()
    }
    
    // MARK: - Actions & methods
    
    func updateViews() {
        guard isViewLoaded,
            let module = module else { return }
        self.title = module.name
        guidedProjectStars.value = Int(module.confidence)
        afternoonProjectStars.value = Int(module.rating)
    }
    
    func objectiveMastered(on cell: ObjectiveTableViewCell) {
        guard let module = module else { return }
        module.objectiveMastery += 1
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
    
    
    private func calculateMastery() -> Double {
        guard let module = module else { return 0 }
        let oMastery = module.objectiveMastery / Double(module.objectives!.count)
        arithmetic = oMastery + module.confidence + module.rating
        
        switch arithmetic {
        case 4..<5:
            module.mastery = 90
        case 3.5..<4:
            module.mastery = 80
        case 3..<3.5:
            module.mastery = 70
        case 2.5..<3:
            module.mastery = 60
        case 2..<2.5:
            module.mastery = 50
        default:
            module.mastery = 100
        }
        return module.mastery
    }
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let module = module else { return }
        moduleController?.updateModule(module: module, confidence: module.confidence, rating: module.rating, mastery: calculateMastery())
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
}

// MARK: - Table view data source

extension ModuleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let module = module,
            let objectives = module.objectives else { return 0 }
        return objectives.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ObjectiveCell", for: indexPath) as? ObjectiveTableViewCell
            else { return UITableViewCell() }
        cell.delegate = self
        guard let module = module,
            let objectives = module.objectives else { return UITableViewCell() }
        let objective = objectives[indexPath.row]
        cell.textLabel?.numberOfLines = 0
        cell.textLabel?.lineBreakMode = .byWordWrapping
        cell.objectiveLabel.text = objective
        return cell
    }
}

// MARK: - Theming

extension ModuleDetailViewController {
    
    func setTheme() {
        tableView.layer.cornerRadius = 25.0
        tableView.layer.borderWidth = 3.0
        tableView.layer.borderColor = ThemeHelper.lambdaLightBlue.cgColor
        
        saveButton.setTitleColor(ThemeHelper.lambdaRed, for: .normal)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderColor = ThemeHelper.lambdaRed.cgColor
    }
    
}
