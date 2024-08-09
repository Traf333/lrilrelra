//
//  Item.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import Foundation
import SwiftData

@Model
final class Scenario {
    @Attribute(.unique) var id: UUID
    var title: String
    var timestamp: Date
    var plot: String?
    var author: String?
    var actors: [Actor]
    var speeches: [Speech]
    
    init(title: String, timestamp: Date, plot: String? = nil, author: String? = nil, actors: [Actor] = [], speeches: [Speech] = []) {
        self.id = UUID()
        self.title = title
        self.timestamp = timestamp
        self.plot = plot
        self.author = author
        self.actors = actors
        self.speeches = speeches
    }
    
}
