//
//  Speech.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import Foundation
import SwiftData

@Model
final class Speech {
    @Attribute(.unique) var id: UUID
    var content: String
    var position: Int
    var audioVersions: [URL]
    var actor: Actor?
    
    init(content: String, position: Int, actor: Actor?) {
        self.id = UUID()
        self.content = content
        self.position = position
        self.audioVersions = []
        self.actor = actor
    }
}
