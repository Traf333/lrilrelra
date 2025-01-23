//
//  PlayerViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 24.12.2024.
//

import AVFoundation
import SwiftUI

class PlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
  @Published var audios: [Audio] = []
  @Published var recordedAudio: Audio?
  @Published var isPlaying = false
  @Published var isRecording = false

  private var audioRecorder: AVAudioRecorder?
  private var audioPlayer: AVAudioPlayer?

  var scenarioId: String
  var speechId: String

  init(scenarioId: String, speechId: String) {
    self.scenarioId = scenarioId
    self.speechId = speechId

//    self.recordedAudio = audios.first
    self.audios = []
  }

  func startRecording() {
    let audioSession = AVAudioSession.sharedInstance()
    do {
      try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
      try audioSession.setActive(true)
    } catch {
      print("Failed to set up audio session: \(error)")
      return
    }

    let audioFilename = getDocumentsDirectory().appendingPathComponent("\(speechId).m4a")
    do {
      audioRecorder = try AVAudioRecorder(
        url: audioFilename,
        settings: [
          AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
          AVSampleRateKey: 44100.0,
          AVNumberOfChannelsKey: 1,
          AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
        ]
      )
      audioRecorder?.record()
      isRecording = true
    } catch {
      print("Failed to start recording: \(error)")
    }
  }

  func stopRecording() {
    audioRecorder?.stop()
    isRecording = false
    if let audioURL = audioRecorder?.url {
      do {
        let audioData = try Data(contentsOf: audioURL)
        audioPlayer = try AVAudioPlayer(data: audioData)

        let newAudio = Audio(
          id: UUID().uuidString,
          scenarioId: scenarioId,
          speechId: speechId,
          audioData: audioData,
          uploadedAt: Date()
        )
        recordedAudio = newAudio
      } catch {
        print("Failed to load audio data: \(error)")
      }
    }
  }

  func saveRecord() async {
    if let audioData = audioRecorder?.url {
      let newAudio = Audio(
        id: UUID().uuidString,
        scenarioId: scenarioId,
        speechId: speechId,
        audioData: try! Data(contentsOf: audioData),
        uploadedAt: Date()
      )
      do {
        try await DittoService.shared.ditto.store.execute(
          query: "INSERT INTO `audios` DOCUMENTS (:newAudio) ON ID CONFLICT DO UPDATE",
          arguments: ["newAudio": newAudio.docDictionary()]
        )
      } catch {
        print("Error saving audio: \(error)")
      }
    }
  }

  func play() {
    audioPlayer?.delegate = self
    audioPlayer?.volume = 1
    audioPlayer?.play()
    isPlaying = true
  }

  func pause() {
    audioPlayer?.stop()
    isPlaying = false
  }

  // MARK: - AVAudioPlayerDelegate
  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
    isPlaying = false
  }

  func duration() -> TimeInterval {
    guard let duration = audioPlayer?.duration else { return 0 }
    return duration
  }

  private func getDocumentsDirectory() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
  }
}
