//
//  ModuleController.swift
//  Progress
//
//  Created by Mitchell Budge on 11/18/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation
import CoreData

class CareerController {

    // MARK: - Methods
    
    init() {
        decodeJSON()
    }
    
    private func decodeJSON(completion: @escaping ((Error?) -> Void) = { _ in }) {
        guard let jsonLocation = Bundle.main.url(forResource: "Careers", withExtension: "json") else {
            NSLog("Error locating JSON file")
            completion(NSError())
            return
        }
        guard let jsonData = try? Data(contentsOf: jsonLocation) else {
            NSLog("No data returned from json file")
            completion(NSError())
            return
        }
        var careerReps: [CareerRepresentation] = []
        let jsonDecoder = JSONDecoder()
        let fetchRequest: NSFetchRequest<Career> = Career.fetchRequest()
        let context = CoreDataStack.shared.container.newBackgroundContext()
        context.performAndWait {
            do {
                careerReps = try jsonDecoder.decode([CareerRepresentation].self, from: jsonData)
                let existingCareers = try context.fetch(fetchRequest)
                if existingCareers == [Module]() {
                    for career in careerReps {
                        Career(careerRepresentation: career, context: context)
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
    
    func updateCareer(career: Career, completed: Bool) {
        career.completed = completed
        CoreDataStack.shared.save()
    }
}
