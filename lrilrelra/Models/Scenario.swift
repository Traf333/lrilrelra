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
    var title: String
    var timestamp: Date
    var personsCount: Int
    var plot: String?
    var author: String?
    
    init(timestamp: Date, title: String, plot: Optional<String>, author: Optional<String>) {
        self.timestamp = timestamp
        self.title = title
        self.plot = plot
        self.author = author       
        self.personsCount = 5
    }
}
