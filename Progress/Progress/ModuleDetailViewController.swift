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
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var guidedStarsButton: UIButton!
    @IBOutlet weak var afternoonStarsButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
    
    // MARK: - View lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // MARK: - Actions
    
    @IBAction func saveButtonPressed(_ sender: Any) {
        
    }
    
    
}

extension ModuleDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}
