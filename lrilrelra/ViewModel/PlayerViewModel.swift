//
//  PlayerViewModel.swift
//  lrilrelra
//
//  Created by Igor Trofimov on 24.12.2024.
//

import AVFoundation
import RealmSwift
import SwiftUI

class PlayerViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    @Published var audios: [Audio] = []
    @Published var isPlaying = false
    @Published var isRecording = false
    
    private var audioRecorder: AVAudioRecorder?
    private var audioPlayer: AVAudioPlayer?
    
    var scenarioId: ObjectId
    var speechId: ObjectId
    
    init(scenarioId: ObjectId, speechId: ObjectId) {
        self.scenarioId = scenarioId
        self.speechId = speechId
    }
    
    func startRecording() {
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(.playAndRecord, mode: .default)
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
                let newAudio = Audio()
                newAudio.scenarioId = scenarioId
                newAudio.speechId = speechId
                newAudio.audioData = audioData
                newAudio.uploadedAt = Date()
                audios.append(newAudio)
            } catch {
                print("Failed to load audio data: \(error)")
            }
        }
    }
    
    func play() {
        guard let audioData = audios.first?.audioData else { return }
        do {
            audioPlayer = try AVAudioPlayer(data: audioData)
            audioPlayer?.delegate = self
            audioPlayer?.play()
            isPlaying = true
        } catch {
            print("Cannot play audio: \(error)")
        }
    }
    
    func pause() {
        audioPlayer?.stop()
        isPlaying = false
    }
    
    // MARK: - AVAudioPlayerDelegate
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        isPlaying = false
    }
    
    private func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

