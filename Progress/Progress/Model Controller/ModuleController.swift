//
//  ModuleController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

class ModuleController {
    
    var modules: [ModuleRepresentation] = []
    
    func decodeJSON() {
        guard let jsonLocation = Bundle.main.url(forResource: "Modules", withExtension: "json") else {
            // TODO: - improve error handling
            fatalError()
        }
        guard let jsonData = try? Data(contentsOf: jsonLocation) else {
           // TODO: - improve error handling
            fatalError()
        }
        let jsonDecoder = JSONDecoder()
        do {
            let downloadedModules = try jsonDecoder.decode([ModuleRepresentation].self, from: jsonData)
            modules = downloadedModules
            CoreDataStack.shared.save()
        } catch {
            NSLog("Error decoding JSON data: \(error)")
            return
        }
    }
    
    // TODO: - add update method
    
}
