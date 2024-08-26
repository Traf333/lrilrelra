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
    var onSubmit: () -> Void
    
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
                    }
                }
                .navigationTitle("Add Scenario")
                .navigationBarItems(leading: Button("Cancel") {
                    isPresented = false
                }, trailing: Button("Submit") {
                    onSubmit()
                })
            }
            .frame(height: UIScreen.main.bounds.height * 0.75) // 3/4 of the screen height
        }
    }
}

struct FilePickerView: View {
    @Binding var content: String
    @State private var isDocumentPickerPresented = false
    
    var body: some View {
        Button("Select .txt File") {
            isDocumentPickerPresented = true
        }
        .sheet(isPresented: $isDocumentPickerPresented) {
            DocumentPicker(content: $content)
        }
        
        if !content.isEmpty {
            Text("Content loaded successfully.")
                .font(.footnote)
                .foregroundColor(.green)
        }
    }
}

