////
////  PlayerViewModel.swift
////  lrilrelra
////
////  Created by Igor Trofimov on 24.12.2024.
////
//
//import AVFoundation
//import RealmSwift
//import SwiftUI
//
//class PlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
//  @Published var audios: [Audio] = []
//  @Published var recordedAudio: Audio?
//  @Published var isPlaying = false
//  @Published var isRecording = false
//
//  private var audioRecorder: AVAudioRecorder?
//  private var audioPlayer: AVAudioPlayer?
//
//  var scenarioId: ObjectId
//  var speechId: ObjectId
//
//  init(scenarioId: ObjectId, speechId: ObjectId) {
//    self.scenarioId = scenarioId
//    self.speechId = speechId
//    let realm = try! Realm()
//    let audios = realm.objects(Audio.self).filter("speechId == %@", speechId)
//    self.recordedAudio = audios.first
//    self.audios = Array(audios)
//  }
//
//  func startRecording() {
//    let audioSession = AVAudioSession.sharedInstance()
//    do {
//      try audioSession.setCategory(.playAndRecord, mode: .default, options: .defaultToSpeaker)
//      try audioSession.setActive(true)
//    } catch {
//      print("Failed to set up audio session: \(error)")
//      return
//    }
//
//    let audioFilename = getDocumentsDirectory().appendingPathComponent("\(speechId).m4a")
//    do {
//      audioRecorder = try AVAudioRecorder(
//        url: audioFilename,
//        settings: [
//          AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
//          AVSampleRateKey: 44100.0,
//          AVNumberOfChannelsKey: 1,
//          AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue,
//        ]
//      )
//      audioRecorder?.record()
//      isRecording = true
//    } catch {
//      print("Failed to start recording: \(error)")
//    }
//  }
//
//  func stopRecording() {
//    audioRecorder?.stop()
//    isRecording = false
//    if let audioURL = audioRecorder?.url {
//      do {
//        let audioData = try Data(contentsOf: audioURL)
//        audioPlayer = try AVAudioPlayer(data: audioData)
//
//        let newAudio = Audio()
//        newAudio.scenarioId = scenarioId
//        newAudio.speechId = speechId
//        newAudio.audioData = audioData
//        newAudio.uploadedAt = Date()
//        recordedAudio = newAudio
//      } catch {
//        print("Failed to load audio data: \(error)")
//      }
//    }
//  }
//
//  func saveRecord() {
//    if let audioData = audioRecorder?.url {
//      let newAudio = Audio()
//      newAudio.scenarioId = scenarioId
//      newAudio.speechId = speechId
//      newAudio.audioData = try! Data(contentsOf: audioData)
//      newAudio.uploadedAt = Date()
//
//      let realm = try! Realm()
//      try! realm.write {
//        realm.add(newAudio)
//      }
//    }
//  }
//
//  func play() {
//    audioPlayer?.delegate = self
//    audioPlayer?.volume = 1
//    audioPlayer?.play()
//    isPlaying = true
//  }
//
//  func pause() {
//    audioPlayer?.stop()
//    isPlaying = false
//  }
//
//  // MARK: - AVAudioPlayerDelegate
//  func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
//    isPlaying = false
//  }
//
//  func duration() -> TimeInterval {
//    guard let duration = audioPlayer?.duration else { return 0 }
//    return duration
//  }
//
//  private func getDocumentsDirectory() -> URL {
//    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
//    return paths[0]
//  }
//}
