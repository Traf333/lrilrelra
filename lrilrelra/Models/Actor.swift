//
//  Actor.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import Foundation
import SwiftData

@Model
final class Actor {
    @Attribute(.unique) var id: UUID
    var name: String
    var details: String?
    
    init(name: String, details: String? = nil) {
        self.id = UUID()
        self.name = name
        self.details = details
    }
}
