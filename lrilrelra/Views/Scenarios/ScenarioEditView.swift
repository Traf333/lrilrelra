//
//  ScenarioEditView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.09.2024.
//

import SwiftUI
import RealmSwift

struct RoleRowView: View {
    @Binding var role: Role
    @State private var showAliases = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                TextField("Role Name", text: $role.name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                Button(action: {
                    
                    showAliases.toggle()
                    
                }) {
                    Image(systemName: showAliases ? "minus.circle.fill" : "plus.circle.fill")
                        .foregroundColor(showAliases ? .red : .blue)
                }
                .buttonStyle(BorderlessButtonStyle()) // For better interaction in a Form
                .accessibilityLabel(showAliases ? "Hide aliases" : "Add aliases")
            }
            
            if showAliases {
                TextField("Role Aliases", text: $role.aliases)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
            
            Divider()
        }
    }
}

struct ScenarioEditView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedRealmObject var scenario: Scenario
    
    var body: some View {
        Form {
            Section {
                TextField("Title", text: $scenario.title)
                TextField("Author", text: $scenario.author, prompt: Text("Author"))
                DatePicker(selection: $scenario.releaseDate, in: ...Date.now, displayedComponents: .date) {
                    Text("Release Date")
                }
            } header: {
                Text("Details")
            }
            Section {
                ForEach($scenario.roles) { role in
                    RoleRowView(role: role)
                }
                .onDelete { indexSet in
                    $scenario.roles.remove(atOffsets: indexSet)
                }
                
            } header: {
                HStack {
                    Text("Roles")
                    Spacer()
                    Button(action: {
                        let newRole = Role()
                        newRole.name = "New Role"
                        newRole.aliases = ""
                        $scenario.roles.append(newRole)
                    }) {
                        HStack {
                            Image(systemName: "plus")
                            Text("Add Role")
                        }
                    }
                }
                
            }
        }
        .navigationTitle("Edit Scenario")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save") {
//                    viewModel.saveChanges()
                    dismiss()
                }
            }
        }
    }
}

#Preview {
   ScenarioEditView(scenario: Scenario.example())
}
