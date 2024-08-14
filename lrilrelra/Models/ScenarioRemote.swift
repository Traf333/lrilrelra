//
//  ScenarioRemote.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 13.08.2024.
//

import Foundation

struct ScenarioRemote: Codable, Identifiable {
    var id: Int?
    var title: String
    var content: String
    var actorsNumber: Int
}
