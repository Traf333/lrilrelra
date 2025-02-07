//
//  SpeechEditView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.09.2024.
//

import SwiftUI

struct SpeechEditView: View {
  var speech: Speech
  var onSave: (Speech) async -> Void

  @Environment(\.dismiss) var dismiss
  @State private var content: String = ""

  init(speech: Speech, onSave: @escaping (Speech) async -> Void) {
    self.speech = speech
    self.onSave = onSave
    self._content = State(wrappedValue: speech.content)
  }

  var body: some View {
    Form {
      Section(header: Text("Edit Speech")) {
        TextEditor(text: $content)
          .frame(height: 200)  // Set the height for a text area-like behavior
          .padding(.horizontal, 4)
      }

    }
    .navigationTitle("Edit Speech")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Save") {
            Task {
                await  onSave(speech.updated(content: content))
            }
          dismiss()
        }
      }
    }
  }
}

extension Speech {
  func updated(content: String) -> Speech {
    Speech(id: id, scenarioId: scenarioId, content: content, position: position)
  }
}
