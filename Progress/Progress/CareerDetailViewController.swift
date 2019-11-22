//
//  CareerDetailViewController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/21/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class CareerDetailViewController: UIViewController {

    // MARK: - Properties and outlets
    
    var career: Career? {
        didSet {
            updateViews()
        }
    }
    var careerController: CareerController?
    
    @IBOutlet weak var assignmentTextView: UITextView!
    @IBOutlet weak var infoTextView: UITextView!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViews()
        setTheme()
    }
    
    // MARK: - Methods
    func updateViews() {
        guard isViewLoaded,
            let career = career else { return }
        title = career.name
        assignmentTextView.text = career.assignment
        infoTextView.text = career.info
    }
    @IBAction func saveButtonPressed(_ sender: Any) {
        guard let career = career else { return }
        career.completed = true
        careerController?.updateCareer(career: career, completed: career.completed)
        navigationController?.popToRootViewController(animated: true)
    }
    
    func setTheme() {
        saveButton.setTitleColor(ThemeHelper.lambdaRed, for: .normal)
        saveButton.layer.borderWidth = 0.5
        saveButton.layer.cornerRadius = 10.0
        saveButton.layer.borderColor = ThemeHelper.lambdaRed.cgColor
    }
}
