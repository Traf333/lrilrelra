//
//  ScenarioRemoteView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.08.2024.
//

import SwiftUI

struct ScenarioRemoteView: View {
    @ObservedObject var viewModel: LibraryViewModel
    var scenario: ScenarioRemote
    
    var body: some View {
        VStack(alignment: .leading) {
            List {
                ForEach(scenario.content.split(separator: "\n"), id: \.self) { line in
                    Text(line).listRowSeparator(.hidden,  edges: [.bottom])
                         // Add vertical padding between lines
                }
            }.listStyle(PlainListStyle())
            
        }
        .navigationTitle(scenario.title)
        .navigationBarItems(trailing: Button("Delete") {
            if let id = scenario.id {
                viewModel.deleteScenario(id: id)
            }
        })

    }
}

#Preview {
    func loadTextFile(fileName: String) -> String {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "txt"),
           let content = try? String(contentsOf: url) {
            return content
        }
        return "Failed to load content."
    }
    
    let content = loadTextFile(fileName: "zov")
    
    return ScenarioRemoteView(viewModel: LibraryViewModel(), scenario: ScenarioRemote(title: "Banana dance", content: content, actorsNumber: 5))
}
