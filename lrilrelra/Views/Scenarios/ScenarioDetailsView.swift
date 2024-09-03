//
//  ScenarioDetailsView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.08.2024.
//

import SwiftUI
import SwiftData

struct ScenarioDetailsView: View {
    var scenario: Scenario
    
    @State var selectedRole: Role? = nil
    @State var showRoleSelector = false
    
    var roles = [Role(name: "Лиля", aliases: ["Лилия"]), Role(name: "Сергей Геннадьевич", aliases: ["С.Г"])]
    
    var body: some View {
        
        VStack(alignment: .leading) {
            List {
                ForEach(scenario.speeches.sorted(by: {$0.position < $1.position})) { speech in
                    VStack(alignment: .leading) {
                        Text(speech.content).opacity(getOpacity(speech.content))
                    }
                    .listRowSeparator(.hidden)
                    //                    .listRowInsets(EdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 0))
                }
            }.listStyle(PlainListStyle())
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button(action: {showRoleSelector = true}) {
                            Image(systemName: "person.2").foregroundColor(selectedRole != nil ? .blue : .gray)
                            
                            
                        }
                    }
                }
        }
        .navigationTitle(scenario.title)
        .sheet(isPresented: $showRoleSelector) {
            RoleSelectorView(selectedRole: $selectedRole, roles: roles) {
                showRoleSelector = false
            }.presentationDragIndicator(.visible)
        }
        
    }
    
    private func getOpacity(_ content: String) -> Double {
        if let selectedRole = selectedRole {
            let allNames = [selectedRole.name] + selectedRole.aliases
            
            if allNames.contains(where: {name in content.hasPrefix(name)}) {
                return 1
            } else {
                return 0.5
            }
        } else {
            return 1
        }
    }
    
}

#Preview {
    let container = try! ModelContainer(for: Scenario.self) // Use inMemory storage for previews
    
    // Add a sample scenario to the in-memory container for preview
    let context = ModelContext(container)
    
    
    // Fetch the first scenario from the context for preview
    if let firstScenario = try? context.fetch(FetchDescriptor<Scenario>()).first {
        return NavigationStack {
            ScenarioDetailsView(scenario: firstScenario)
                .modelContainer(container)
        }
    } else {
        return Text("problem to preview")
    }
}


