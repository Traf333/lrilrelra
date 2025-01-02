//
//  PlayerView.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 22.12.2024.

import AVFoundation
import RealmSwift
import SwiftUI

struct PlayerView: View {
  @StateObject private var viewModel: PlayerViewModel

  init(scenarioId: ObjectId, speechId: ObjectId) {
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
            viewModel.isRecording ? viewModel.stopRecording() : viewModel.startRecording()
          }
        )
        
        Button("Save", systemImage: "tray.and.arrow.down.fill", action: { /* Save action */  })
      }
    }
  }
}

struct PlayerView_Previews: PreviewProvider {
  static var scenario = Scenario.example()
  static var previews: some View {

    PlayerView(scenarioId: scenario._id, speechId: scenario.speeches.first!._id)
  }
}
