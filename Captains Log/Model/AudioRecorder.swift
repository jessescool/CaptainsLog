import Foundation
import SwiftUI
import Combine
import AVFoundation
import AVFAudio

class AudioRecorder: ObservableObject {
    
    enum RecorderError: Error {
        case notPermittedToRecord
        
        var message: String {
            switch self {
            case .notPermittedToRecord: return "Not authorized to record audio"
            }
        }
    }
    
    var audioSession: AVAudioSession?
    var recorder: AVAudioRecorder?
    
    func startRecording() {
        DispatchQueue(label: "Recorder Queue", qos: .background).async { [weak self] in
            guard let self = self, let audioSession = self.audioSession, let recorder = self.recorder else {
                print("nope")
            }
            
            do {
                let (audioSession, recorder) = try Self.prepareRecorder()
                self.audioSession = audioSession
                self.recorder = recorder
            } catch {
                print(error)
            }
    }
    
    static private func prepareRecorder() throws -> (AVAudioSession, AVAudioRecorder) {
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(.record, mode: .default, options: .duckOthers)
        try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        
        func getDocumentsDirectory() -> URL {
            let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("recording.m4a")

        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        
        let recorder = try AVAudioRecorder(url: audioFilename, settings: settings)
        recorder.prepareToRecord()
        
        return (audioSession, recorder)
        
    }
    
    
}

