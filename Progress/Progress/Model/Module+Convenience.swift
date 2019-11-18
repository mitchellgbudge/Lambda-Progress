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
                                        mastery: Bool = false,
                                        confidence: Double = 1.0,
                                        rating: Double = 1.0,
                                        identifier: String = UUID().uuidString,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.unit = unit
        self.mastery = mastery
        self.confidence = confidence
        self.rating = rating
        self.identifier = identifier
    }
    
    // TODO: - Add Module representation convenience init
    
}
