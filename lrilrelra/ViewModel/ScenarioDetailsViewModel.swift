//
//  ScenarioDetailsViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.09.2024.
//

import Foundation
import SwiftUI

final class ScenarioDetailsViewModel: ObservableObject {
    @AppStorage("lastSpeechIdString") var lastSpeechIdString: String?
    @Published var current: [Speech] = []
    @Published var selectedRole: Role?  = nil
    
    let saveInterval = 20.0
    var timer: Timer?
    
    init() {
        
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(withTimeInterval: saveInterval, repeats: true) { _ in
            self.saveFirstVisibleSpeech()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        timer = nil
    }
    
    func saveFirstVisibleSpeech() {
        if let firstVisibleSpeech = current.first {
            lastSpeechIdString = firstVisibleSpeech.id.uuidString
        }
    }
    
    func getOpacity(_ content: String) -> Double {
        if let selectedRole = selectedRole {
            let allNames = [selectedRole.name] + selectedRole.aliases
            if allNames.contains(where: { name in content.hasPrefix(name) }) {
                return 1
            } else {
                return 0.5
            }
        } else {
            return 1
        }
    }
}
