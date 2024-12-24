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
        _viewModel = StateObject(wrappedValue: PlayerViewModel(scenarioId: scenarioId, speechId: speechId))
    }
    
    var body: some View {
        HStack {
            if viewModel.audios.count > 0 {
                // Display playback controls and recording button
                Spacer()
                
                // Back Button
                Button(action: {
                    // Handle back action
                }) {
                    Image(systemName: "backward.fill")
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                
                Spacer()
                
                // Play/Pause Button
                Button(action: {
                    viewModel.isPlaying ? viewModel.pause() : viewModel.play()
                }) {
                    Image(systemName: viewModel.isPlaying ? "pause.fill" : "play.fill")
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
                
                Spacer()
                
                // Forward Button
                Button(action: {
                    // Handle forward action
                }) {
                    Image(systemName: "forward.fill")
                        .frame(width: 50, height: 50)
                        .background(Circle().fill(Color.gray.opacity(0.2)))
                }
            }
            
            Spacer()
            
            // Record Button
            Button(action: {
                viewModel.isRecording ? viewModel.stopRecording() : viewModel.startRecording()
            }) {
                Image(systemName: viewModel.isRecording ? "stop.circle.fill" : "mic.fill")
                    .frame(width: 40, height: 40)
                    .background(Circle().fill(Color.red.opacity(0.2)))
            }
            
            Spacer()
        }
        .padding()
        .background(Color(UIColor.systemBackground).opacity(0.95))
        .shadow(radius: 10)
    }
}



struct PlayerView_Previews: PreviewProvider {
    static var scenario = Scenario.example()
    static var previews: some View {
        
        PlayerView(scenarioId: scenario._id, speechId: scenario.speeches.first!._id)
    }
}
