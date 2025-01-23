//
//  AddScenarioModalView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.08.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct AddScenarioModalView: View {
  @Binding var newTitle: String
  @Binding var newAuthor: String
  @Binding var newActorsNumber: Int
  @Binding var newContent: String

  @State private var publishToLibrary = true

  var onCancel: () -> Void
  var onSubmit: (ScenarioRemote, Bool) -> Void

  var body: some View {
    NavigationView {
      VStack {
        Form {
          Section(header: Text("Scenario Details")) {
            TextField("Title", text: $newTitle)
              .autocapitalization(.none)
              .disableAutocorrection(true)

            TextField("Author", text: $newAuthor)
              .autocapitalization(.none)
              .disableAutocorrection(true)

            FilePickerView(content: $newContent)
            Toggle("Publish to Library", isOn: $publishToLibrary)
          }
        }
        .navigationTitle("Add Scenario")
        .navigationBarItems(
          leading: Button("Cancel") {
            onCancel()
          },
          trailing: Button("Submit") {
            onSubmit(
              ScenarioRemote(
                title: newTitle, content: newContent, author: newAuthor,
                actorsNumber: newActorsNumber),
              publishToLibrary
            )
          })
      }
    }
  }
}
