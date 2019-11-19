//
//  Module+Convenience.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

extension Module {
    
    @discardableResult convenience init(name: String,
                                        unit: String,
                                        objectives: [String],
                                        mastery: Bool = false,
                                        sprint: Int16,
                                        confidence: Double = 1.0,
                                        rating: Double = 1.0,
                                        identifier: String = UUID().uuidString,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.unit = unit
        self.objectives = objectives
        self.mastery = mastery
        self.sprint = sprint
        self.confidence = confidence
        self.rating = rating
        self.identifier = identifier
    }
    
    // TODO: - Add Module representation convenience init
    
}
