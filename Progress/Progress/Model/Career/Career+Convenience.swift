//
//  Career+Convenience.swift
//  Progress
//
//  Created by Mitchell Budge on 11/21/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

extension Career {
    
    @discardableResult convenience init(name: String,
                                        assignment: String,
                                        info: String,
                                        completed: Bool,
                                        context: NSManagedObjectContext = CoreDataStack.shared.mainContext) {
        self.init(context: context)
        self.name = name
        self.assignment = assignment
        self.info = info
        self.completed = completed
    }
    
    @discardableResult convenience init?(careerRepresentation: CareerRepresentation, context: NSManagedObjectContext) {
        
        guard let name = careerRepresentation.name,
            let assignment = careerRepresentation.assignment,
            let info = careerRepresentation.info,
            let completed = careerRepresentation.completed else { return nil }
        
        self.init(name: name, assignment: assignment, info: info, completed: completed, context: context)
    }
    
    var careerRepresentation: CareerRepresentation {
        return CareerRepresentation(name: name, assignment: assignment, info: info, completed: completed)
    }
    
}
