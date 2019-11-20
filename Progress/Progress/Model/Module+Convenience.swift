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
                                        mastery: Double = 0,
                                        sprint: Double,
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
    
    @discardableResult convenience init?(moduleRepresentation: ModuleRepresentation, context: NSManagedObjectContext) {
        
        guard let name = moduleRepresentation.name,
            let unit = moduleRepresentation.unit,
            let objectives = moduleRepresentation.objectives,
            let mastery = moduleRepresentation.mastery,
            let sprint = moduleRepresentation.sprint,
            let confidence = moduleRepresentation.confidence,
            let rating = moduleRepresentation.rating,
            let identifier = moduleRepresentation.identifier else { return nil }
        
        self.init(name: name, unit: unit, objectives: objectives, mastery: mastery, sprint: sprint, confidence: confidence, rating: rating, identifier: identifier, context: context)
    }
    
    var moduleRepresentation: ModuleRepresentation {
        return ModuleRepresentation(name: name, unit: unit, objectives: objectives, mastery: mastery, sprint: sprint, confidence: confidence, rating: rating, identifier: identifier)
    }
    
}
