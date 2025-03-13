//
//  PlayerView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 22.12.2024.

import AVFoundation
import SwiftUI

struct PlayerView: View {
  let scenarioId: String
  let speechId: String
  let onAudioSave: (URL) async -> Void

  @StateObject private var viewModel: PlayerViewModel

  init(
    scenarioId: String, speechId: String,
    onAudioSave: @escaping (URL) async -> Void
  ) {
    self.scenarioId = scenarioId
    self.speechId = speechId
    self.onAudioSave = onAudioSave

    _viewModel = StateObject(
      wrappedValue: PlayerViewModel(scenarioId: scenarioId, speechId: speechId))
  }

  var body: some View {

    HStack {
      ControlGroup {
        Button("Back", systemImage: "backward.fill", action: { /* Action for back */  })
        Button(
          "Play/Pause", systemImage: viewModel.isPlaying ? "pause.fill" : "play.fill",
          action: {
            viewModel.isPlaying ? viewModel.pause() : viewModel.play()
          })
        Button("Forward", systemImage: "forward.fill", action: { /* Action for forward */  })
      }
      Spacer()
      // Right side buttons
      ControlGroup {

        Button(
          "Play/Pause", systemImage: viewModel.isRecording ? "stop.fill" : "mic.fill",
          action: {
            if viewModel.isRecording {
              viewModel.stopRecording()
            } else {
              viewModel.startRecording()
            }
          }
        )

          if let audioURL = viewModel.recordedAudioUrl() {
              Button(
                "Save", systemImage: "tray.and.arrow.down.fill",
                action: {
                    Task {
                        await onAudioSave(audioURL)
                    }
                    
                })
          }
      }
    }
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var scenario = Scenario.example()
  static var speeches = Speech.examples(n: 1)
  static var previews: some View {

    PlayerView(
        scenarioId: scenario.id, speechId: speeches.first!.id, onAudioSave: { audio in print("Saved: \(audio)")})
  }
}
