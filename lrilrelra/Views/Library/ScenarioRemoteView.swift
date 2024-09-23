//
//  ScenarioRemoteView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.08.2024.
//

import SwiftUI
import RealmSwift

struct ScenarioRemoteView: View {
    @Environment(\.dismiss) private var dismiss
    
    @ObservedObject var viewModel: LibraryViewModel
    
    var scenario: ScenarioRemote
    var canDelete = true
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
        })
        
    }
    
    private func addItem() {
        let newScenario = scenario.buildScenario()
        let realm = try! Realm()
        
        // Save to Realm
        do {
            try realm.write {
                realm.add(newScenario)
            }
        } catch {
            print("Failed to save scenario: \(error.localizedDescription)")
        }
        ////        modelContext.autosaveEnabled = false
        ////        modelContext.undoManager = nil
        //        modelContext.insert(scn)
        //        Task.detached(priority: .background) {
        //            speeches.forEach{
        //                scn.speeches.append($0)
        //            }
        //        }
        
        
        //        modelContext.autosaveEnabled = true
        dismiss()
    }
}

#Preview {
    LibraryView()
}
