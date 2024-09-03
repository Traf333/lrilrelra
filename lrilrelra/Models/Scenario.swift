//
//  Item.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import Foundation
import SwiftData

@Model
final class Role {
    let name: String
    let aliases: [String]
    
    init(name: String, aliases: [String]) {
        self.name = name
        self.aliases = aliases
    }
}

@Model
final class Scenario {
    @Attribute(.unique) var id: UUID
    var title: String
    var timestamp: Date
    var plot: String?
    var author: String?
    var roles: [Role]
    var speeches: [Speech]
    
    init(title: String, timestamp: Date, plot: String? = nil, author: String? = nil, roles: String, speeches: [Speech] = []) {
        self.id = UUID()
        self.title = title
        self.timestamp = timestamp
        self.plot = plot
        self.author = author
        self.roles = roles.split(separator: ",").map {
            Role(name: $0.trimmingCharacters(in: .whitespacesAndNewlines), aliases: [])
        }
        self.speeches = speeches
    }
    
}
