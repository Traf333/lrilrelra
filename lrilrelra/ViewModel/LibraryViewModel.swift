//
//  ScenarioViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 13.08.2024.
//

import Foundation

class LibraryViewModel: ObservableObject {
    @Published var scenarios: [ScenarioRemote] = []
    
    init() {
        fetchScenarios()
    }
    
    static func mock() -> LibraryViewModel {
        let viewModel = LibraryViewModel()
        viewModel.scenarios = [
            ScenarioRemote(title: "Sample Scenario 1", content: "Sample Content 1", author: "Author 1", actorsNumber: 2),
            ScenarioRemote(title: "Sample Scenario 2", content: "Sample Content 2", author: "Author 2", actorsNumber: 4),
            ScenarioRemote(title: "Sample Scenario 3", content: "Sample Content 3", author: "Author 3", actorsNumber: 3)
        ]
        return viewModel
    }
    
    func fetchScenarios() {
        ScenarioAPI.shared.fetchScenarios { scenarios in
            DispatchQueue.main.async {
                self.scenarios = scenarios ?? []
            }
        }
    }
    
    func addScenario(title: String, author: String, content: String, actorsNumber: Int) {
        let newScenario = ScenarioRemote(title: title, content: content, author: author, actorsNumber: actorsNumber)
        
        ScenarioAPI.shared.createScenario(scenario: newScenario) { success in
            if success?.id != nil {
                self.fetchScenarios()
            }
        }
    }
    
    func mockAddScenario(title: String, content: String, actorsNumber: Int) {
        let newScenario = ScenarioRemote(title: title, content: content, actorsNumber: actorsNumber)
        self.scenarios += [newScenario]
    }
    
    func deleteScenario(id: String) {
        ScenarioAPI.shared.deleteScenario(id: id) { success in
            if success {
                self.fetchScenarios()
            }
        }
    }
}
