//
//  EditSpeechView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 12.08.2024.
//

import SwiftUI
import SwiftData

struct EditSpeechView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var speech: Speech
    
    var body: some View {
        Form {
            Section(header: Text("Content")) {
                TextField("Speech Content", text: $speech.content)
            }
            
            Section(header: Text("Position")) {
                Stepper(value: $speech.position, in: 1...1000) {
                    Text("Position: \(speech.position)")
                }
            }
            
            Section(header: Text("Audio Versions")) {
                ForEach(speech.audioVersions.indices, id: \.self) { index in
                    HStack {
                        Text(speech.audioVersions[index].lastPathComponent)
                        Spacer()
                        Button(action: {
                            speech.audioVersions.remove(at: index)
                        }) {
                            Image(systemName: "minus.circle")
                        }
                    }
                }
                Button(action: addAudioVersion) {
                    Label("Add Audio", systemImage: "plus")
                }
            }
        }
        .navigationTitle("Edit Speech")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Delete") {
                    deleteSpeech()
                }
                .foregroundColor(.red)
            }
        }
    }
    
    private func addAudioVersion() {
        // Example URL, replace with actual logic to get a URL
        let newAudioURL = URL(string: "https://example.com/audio.mp3")!
        speech.audioVersions.append(newAudioURL)
    }
    
    private func deleteSpeech() {
        modelContext.delete(speech)
    }
}
