//
//  PlayerViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 24.12.2024.
//

import AVFoundation
import SwiftUI

class PlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
  @Published var isPlaying = false
  @Published var isRecording = false

  private var audioRecorder: AVAudioRecorder?
  private var audioPlayer: AVAudioPlayer?

  var scenarioId: String
  var speechId: String

  init(scenarioId: String, speechId: String) {
    self.scenarioId = scenarioId
    self.speechId = speechId
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

    let audioFilename = getDocumentsDirectory().appendingPathComponent("\(UUID().uuidString).m4a")
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
        audioPlayer = try AVAudioPlayer(contentsOf: audioURL)
      } catch {
        print("Failed to process recorded audio: \(error)")
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

  func recordedAudioUrl() -> URL? {
    audioRecorder?.url
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
