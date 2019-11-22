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
                                        objectiveMastery: Double = 0,
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
        self.objectiveMastery = objectiveMastery
        self.sprint = sprint
        self.mastery = mastery
        self.confidence = confidence
        self.rating = rating
        self.identifier = identifier
    }
    
    @discardableResult convenience init?(moduleRepresentation: ModuleRepresentation, context: NSManagedObjectContext) {
        
        var module = moduleRepresentation
        module.mastery = 0.0
        module.objectiveMastery = 0.0
        module.confidence = 1.0
        module.rating = 1.0
        module.identifier = UUID().uuidString
        
        guard let name = module.name,
            let unit = module.unit,
            let objectives = module.objectives,
            let objectiveMastery = module.objectiveMastery,
            let sprint = module.sprint,
            let mastery = module.mastery,
            let confidence = module.confidence,
            let rating = module.rating,
            let identifier = module.identifier else { return nil }
        self.init(name: name,
                  unit: unit,
                  objectives: objectives,
                  objectiveMastery: objectiveMastery,
                  mastery: mastery,
                  sprint: sprint,
                  confidence: confidence,
                  rating: rating,
                  identifier: identifier,
                  context: context)
    }
    
    var moduleRepresentation: ModuleRepresentation {
        return ModuleRepresentation(name: name,
                                    unit: unit,
                                    objectives: objectives,
                                    objectiveMastery: objectiveMastery,
                                    sprint: sprint,
                                    mastery: mastery,
                                    confidence: confidence,
                                    rating: rating,
                                    identifier: identifier)
    }
    
}
