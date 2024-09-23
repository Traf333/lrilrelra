//
//  SpeechEditView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 14.09.2024.
//

import SwiftUI

struct SpeechEditView: View {
    
    @Environment(\.dismiss) var dismiss

    
    var body: some View {
        Form {
            Section(header: Text("Edit Speech")) {
//                TextEditor(text: $speech.content)
//                    .frame(height: 200)  // Set the height for a text area-like behavior
//                                       .padding(.horizontal, 4)
            }
            
    
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

//#Preview {
//    SpeechEditView(speech: SpeechMock.instance())
//}
