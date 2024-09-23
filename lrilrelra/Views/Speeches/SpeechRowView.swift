//
//  SpeechRowView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 07.09.2024.
//

import SwiftUI

struct SpeechRowView: View {
    var speech: Speech
    var onRoleSelect: (String) -> Void
    var onDelete: () -> Void
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(speech.content)  // Display the speech content
        }
        .contextMenu {
            Button {
                onRoleSelect(speech.content)
            } label: {
                Label("Select Role", systemImage: "person.2")
            }

            NavigationLink(destination: SpeechEditView()) {
                Label("Edit", systemImage: "square.and.pencil")
            }
            
            Button(role: .destructive) {
                onDelete()
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .padding(.vertical, 8)
    }
}
//
//#Preview {
//    SpeechRowView(speech: SpeechMock.instance(), onRoleSelect: {content in print(content)}, onDelete: { print("deleted")})
//}
