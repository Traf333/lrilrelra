//
//  ScenarioEditView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 09.09.2024.
//

import SwiftUI

struct RoleRowView: View {
  @Binding var role: Role
  @State private var showAliases = false

  var body: some View {
    VStack(alignment: .leading) {
      HStack {
        TextField("Role Name", text: $role.name)
          .autocapitalization(.none)
          .disableAutocorrection(true)

        Button(action: {

          showAliases.toggle()

        }) {
          Image(systemName: showAliases ? "minus.circle.fill" : "plus.circle.fill")
            .foregroundColor(showAliases ? .red : .blue)
        }
        .buttonStyle(BorderlessButtonStyle())  // For better interaction in a Form
        .accessibilityLabel(showAliases ? "Hide aliases" : "Add aliases")
      }

      if showAliases {
        TextField("Role Aliases", text: $role.aliases)
          .autocapitalization(.none)
          .disableAutocorrection(true)
          .transition(.move(edge: .top).combined(with: .opacity))
        Text("Separate aliases by comma")
          .font(.caption)
          .foregroundColor(.secondary)
      }

    }
  }
}

struct ScenarioEditView: View {
  @StateObject var viewModel: ScenarioDetailsViewModel
  @Environment(\.dismiss) var dismiss

  var body: some View {
    Form {
      Section {
        TextField("Title", text: $viewModel.scenario.title)
        TextField("Author", text: $viewModel.scenario.author, prompt: Text("Author"))
        YearPickerField(title: "Release year", selection: $viewModel.scenario.releaseYear)

      } header: {
        Text("Details")
      }
      Section {
        ForEach($viewModel.scenario.roles) { role in
          RoleRowView(role: role)
        }
        .onDelete { indexSet in
          viewModel.scenario.roles.remove(atOffsets: indexSet)
        }

      } header: {
        HStack {
          Text("Roles")
          Spacer()
          Button(action: {
            let newRole = Role(id: UUID().uuidString, name: "", aliases: "")
            viewModel.scenario.roles.append(newRole)
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
          Task {
            await viewModel.save()
          }
          dismiss()
        }
      }
    }
  }
}

//#Preview {
//  ScenarioEditView(scenario: Scenario.example())
//}
