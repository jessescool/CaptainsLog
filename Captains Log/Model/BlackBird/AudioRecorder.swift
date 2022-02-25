import AVFAudio

class AudioRecorder: ObservableObject {
    
    var audioRecorder: AVAudioRecorder!
    
    enum RecorderError: Error {
        case notPermittedToRecord
        case sessionFailed
        case recordingError
        case deleteError

        var message: String {
            switch self {
            case .notPermittedToRecord: return "Not authorized to record audio"
            case .sessionFailed: return "Failed to create audio session"
            case .recordingError: return "Could not start recording"
            case .deleteError: return "Audio could not be deleted"
            }
        }
    }

    /// Creates and configues an AVAudioSession object, creates and configures AVAudioRecorder object,  creates an audio file in Documents directory.
    func prepare(filepath url: URL) throws {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            throw RecorderError.sessionFailed
        }
                
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 48000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: url, settings: settings)
            audioRecorder.prepareToRecord()
            print(url)
        } catch {
            throw RecorderError.recordingError
        }
        
    }
    
    /// Begins recording.
    func startRecording() {
        audioRecorder.record()
    }
    
    /// Pauses audio recording.
    func pauseRecording() {
        audioRecorder.pause()
    }
    
    /// Resumes recording, just for clarity
    func resumeRecording() {
        audioRecorder.record()
    }
    
    /// Stops audio recording.
    func stopRecording() {
        audioRecorder.stop()
    }
    
    /// Returns Bool
    func isRecording() -> Bool {
        return audioRecorder.isRecording
    }
    
    /// Returns time since recording began.
    func getDuration() -> TimeInterval {
        return audioRecorder.currentTime
    }
    
    /// Deletes audio files with given URL
    func deleteRecording(urlsToDelete: [URL]) throws {
        for url in urlsToDelete {
            print("Deleting \(url)")
            do {
               try FileManager.default.removeItem(at: url) // this may not work
            } catch {
                throw RecorderError.deleteError
            }
        }
    }
    
    
}
    


