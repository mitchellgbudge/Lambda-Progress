//
//  ObjectiveTableViewCell.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class ObjectiveTableViewCell: UITableViewCell {

    // MARK: - Outlets and properties
    
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    
    
    // MARK: - Actions
    
    @IBAction func starButtonTapped(_ sender: Any) {
        starButton.setImage(UIImage(named: "StarFilled"), for: .normal)
        starButton.performFlare()
    }

}
