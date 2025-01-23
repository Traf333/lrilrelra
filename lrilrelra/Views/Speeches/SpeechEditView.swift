//
//  SpeechEditView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.09.2024.
//

import SwiftUI

struct SpeechEditView: View {
  //   var speech: Speech

  @Environment(\.dismiss) var dismiss
  //   @State private var content: String

  var body: some View {
    Form {
      //   Section(header: Text("Edit Speech")) {
      //     TextEditor(text: $content)
      //       .frame(height: 200)  // Set the height for a text area-like behavior
      //       .padding(.horizontal, 4)
      //   }

    }
    .navigationTitle("Edit Speech")
    .toolbar {
      ToolbarItem(placement: .navigationBarTrailing) {
        Button("Save") {
          dismiss()
        }
      }
    }
  }
}
