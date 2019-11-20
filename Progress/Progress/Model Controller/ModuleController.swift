//
//  ModuleController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

class ModuleController {
    
    // MARK: - Properties
    
    
    
    // MARK: - Methods
    
    init() {
        decodeJSON()
    }
    
    private func decodeJSON(completion: @escaping ((Error?) -> Void) = { _ in }) {
        guard let jsonLocation = Bundle.main.url(forResource: "Modules", withExtension: "json") else {
            NSLog("Error locating JSON file")
            completion(NSError())
            return
        }
        guard let jsonData = try? Data(contentsOf: jsonLocation) else {
            NSLog("No data returned from json file")
            completion(NSError())
            return
        }
        var moduleReps: [ModuleRepresentation] = []
        let jsonDecoder = JSONDecoder()
        let fetchRequest: NSFetchRequest<Module> = Module.fetchRequest()
        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                moduleReps = try jsonDecoder.decode([ModuleRepresentation].self, from: jsonData)
                let existingModules = try context.fetch(fetchRequest)
                if existingModules == [Module]() {
                    for module in moduleReps {
                        Module(moduleRepresentation: module, context: context)
                        CoreDataStack.shared.save(context: context)
                    }
                }
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
    func updateModule(module: Module, confidence: Double, rating: Double, mastery: Double) {
        module.confidence = confidence
        module.rating = rating
        module.mastery = mastery
        CoreDataStack.shared.save()
    }
}
