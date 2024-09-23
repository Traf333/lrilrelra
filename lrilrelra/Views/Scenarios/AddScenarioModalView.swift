//
//  AddScenarioModalView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.08.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct AddScenarioModalView: View {
    @Binding var isPresented: Bool
    @Binding var newTitle: String
    @Binding var newAuthor: String
    @Binding var newActorsNumber: Int
    @Binding var newContent: String
    
    @State private var publishToLibrary = true
    var onSubmit: (ScenarioRemote, Bool) -> Void
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section(header: Text("Scenario Details")) {
                        TextField("Title", text: $newTitle)
                        TextField("Author", text: $newAuthor)
                        
                        Stepper(value: $newActorsNumber, in: 1...20) {
                            Text("Number of Actors: \(newActorsNumber)")
                        }
                        
                        FilePickerView(content: $newContent)
                        Toggle("Publish to Library", isOn: $publishToLibrary)
                    }
                }
                .navigationTitle("Add Scenario")
                .navigationBarItems(leading: Button("Cancel") {
                    isPresented = false
                }, trailing: Button("Submit") {
                    onSubmit(
                        ScenarioRemote(title: newTitle, content: newContent, author: newAuthor, actorsNumber: newActorsNumber),
                        publishToLibrary
                    )
                })
            }
        }
    }
}
