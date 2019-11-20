//
//  ModuleRepresentation.swift
//  Progress
//
//  Created by Mitchell Budge on 11/19/19.
//  Copyright © 2019 Mitchell Budge. All rights reserved.
//

import Foundation

struct ModuleRepresentation: Codable {
    var name: String?
    var unit: String?
    var objectives: [String]?
    var mastery: Double?
    var sprint: Int16
    var confidence: Double?
    var rating: Double?
    var identifier: String?
}

