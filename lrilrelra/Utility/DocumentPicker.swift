//
//  DocumentPicker.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.08.2024.
//

import SwiftUI
import UniformTypeIdentifiers

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var content: String

    func makeCoordinator() -> Coordinator {
        Coordinator(content: $content)
    }

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [UTType.plainText])
        documentPicker.delegate = context.coordinator
        return documentPicker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        @Binding var content: String

        init(content: Binding<String>) {
            _content = content
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            if let textContent = try? String(contentsOf: url) {
                content = textContent
            }
        }
    }
}
