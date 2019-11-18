//
//  ObjectiveTableViewCell.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import UIKit

class ObjectiveTableViewCell: UITableViewCell {

    // MARK: - Outlets
    
    @IBOutlet weak var objectiveLabel: UILabel!
    @IBOutlet weak var masteredButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
