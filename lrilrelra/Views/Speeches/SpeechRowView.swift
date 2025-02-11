//
//  SpeechRowView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 07.09.2024.
//

import SwiftUI

struct SpeechRowView: View {
  var speech: Speech
  var inBookmarks: Bool = false
  var selected: Bool = false
  var onRoleSelect: (String) -> Void
  var onDelete: () -> Void
  var toggleBookmark: (Speech) async -> Void
  var onUpdateSpeech: (Speech) async -> Void

  var body: some View {
    VStack {
      Text(speech.content)  // Display the speech content
    }.padding(8)
      .frame(maxWidth: .infinity, alignment: .leading)
      .background(selected ? Color.teal : Color.white)
      .contextMenu {
        Button {
          onRoleSelect(speech.content)
        } label: {
          Label("Select Role", systemImage: "person.2")
        }

        NavigationLink(
          destination: SpeechEditView(
            speech: speech,
            onSave: onUpdateSpeech
          )
        ) {
          Label("Edit", systemImage: "square.and.pencil")
        }

        Button {
          Task {
            await toggleBookmark(speech)
          }
        } label: {
          Label(
            inBookmarks ? "Remove from bookmarks" : "Add to bookmarks",
            systemImage: inBookmarks ? "bookmark.fill" : "bookmark")

        }

        Button(role: .destructive) {
          onDelete()
        } label: {
          Label("Delete", systemImage: "trash")
        }
      }

  }

}
