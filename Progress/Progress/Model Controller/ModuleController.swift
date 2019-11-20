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
    
    // MARK: - Methods
    
    init() {
        decodeJSON()
    }
    
    func decodeJSON(completion: @escaping ((Error?) -> Void) = { _ in }) {
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
        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                moduleReps = try jsonDecoder.decode([ModuleRepresentation].self, from: jsonData)
                for module in moduleReps {
                    print(module)
                    Module(moduleRepresentation: module, context: context)
                    CoreDataStack.shared.save(context: context)
                }
            } catch {
                NSLog("Error decoding JSON data: \(error)")
                completion(error)
                return
            }
            completion(nil)
        }
    }
    
}
