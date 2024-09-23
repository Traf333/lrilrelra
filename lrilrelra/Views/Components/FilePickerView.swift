//
//  FilePickerView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 04.09.2024.
//

import SwiftUI

struct FilePickerView: View {
    @Binding var content: String
    @State private var isDocumentPickerPresented = false
    
    var body: some View {
        Button("Select .txt File") {
            isDocumentPickerPresented = true
        }.fileImporter(
            isPresented: $isDocumentPickerPresented,
            allowedContentTypes: [.plainText],
            allowsMultipleSelection: false
        ) { result in
            switch result {
            case .success(let urls):
                guard let url = urls.first else { return }
                
                // Start accessing the security-scoped resource
                if url.startAccessingSecurityScopedResource() {
                    defer { url.stopAccessingSecurityScopedResource() }
                    if let textContent = try? String(contentsOf: url) {
                        content = textContent
                    } else {
                        print("Failed to load file content")
                    }
                } else {
                    print("Couldn't access security-scoped resource")
                }
                
            case .failure(let error):
                print("Error selecting files: \(error.localizedDescription)")
            }
        }
        
        if !content.isEmpty {
            Text("Content: \(content.split(separator: "\n").count) lines loaded successfully.")
                .font(.footnote)
                .foregroundColor(.green)
        }
    }
}

// Helper struct to wrap a State variable and pass its Binding
struct StatefulPreviewWrapper<Value, Content: View>: View {
    @State var value: Value
    var content: (Binding<Value>) -> Content
    
    init(_ value: Value, content: @escaping (Binding<Value>) -> Content) {
        _value = State(initialValue: value)
        self.content = content
    }
    
    var body: some View {
        content($value)
    }
}

#Preview {
    StatefulPreviewWrapper("hjjh") { FilePickerView(content: $0) }
}
