//
//  ScenarioRemoteView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.08.2024.
//

import SwiftUI

struct ScenarioRemoteView: View {
    @Environment(\.modelContext) private var modelContext
    @ObservedObject var viewModel: LibraryViewModel
    var scenario: ScenarioRemote
    var canDelete = false
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
        .navigationBarItems(trailing: HStack {
            Button("Save", systemImage: "square.and.arrow.down.on.square") {
                addItem()
            }
            if canDelete {
                Button("Delete", systemImage: "trash") {
                    if let id = scenario.uniqID {
                        viewModel.deleteScenario(id: id)
                    }
                }
            }
        }).toolbar(.hidden, for: .tabBar)

    }
    
    private func addItem() {
        var position = 0
        let speeches: [Speech] = scenario.content.split(separator: "\n").map {
            position += 1
            
            return Speech(content: String( $0), position: position,actor: nil)
        }
        let newItem = Scenario(title: scenario.title, timestamp: Date(), plot: "", author: scenario.author, actors: [], speeches: speeches)
            modelContext.insert(newItem)
    
    }

}

#Preview {
    LibraryView(viewModel: LibraryViewModel.mock())
}
