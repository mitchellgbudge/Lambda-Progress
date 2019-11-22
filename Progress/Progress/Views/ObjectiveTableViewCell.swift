//
//  ObjectiveTableViewCell.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

protocol ObjectiveTableViewCellDelegate: class {
    func objectiveMastered(on cell: ObjectiveTableViewCell)
}

class ObjectiveTableViewCell: UITableViewCell {

    // MARK: - Outlets and properties
    
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var starButton: UIButton!
    weak var delegate: ObjectiveTableViewCellDelegate?
    
    // MARK: - Actions
    
    @IBAction func starButtonTapped(_ sender: Any) {
        delegate?.objectiveMastered(on: self)
        starButton.setImage(UIImage(named: "StarFilled"), for: .normal)
        starButton.performFlare()
    }

}
