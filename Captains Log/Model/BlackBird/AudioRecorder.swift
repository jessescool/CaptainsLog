import AVFAudio

class AudioRecorder: ObservableObject {
    
    var audioRecorder: AVAudioRecorder!
    var isRecording = false
    
    var recordingName: String = ""

    
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
    
//    "\(Date().toString(dateFormat: "MM-dd-yyyy HH:mm:ss")).m4a"
    
    /// Creates and configues an AVAudioSession object, creates an audio file in Documents directory, creates and configures AVAudioRecorder object with path to new audio file.
    /// Begins recording.

    func startRecording() {
        
        let recordingSession = AVAudioSession.sharedInstance()
        
        do {
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
        } catch {
            RecorderError.sessionFailed
        }
        
        let audioFilename = getDocumentsDirectory().appendingPathComponent("\(recordingName).m4a")
        
        let settings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 48000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue
        ]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFilename, settings: settings)
            print(audioFilename)
            // audioRecorder.prepareToRecord() // Is this needed?
            isRecording = true
            audioRecorder.record()
        } catch {
            isRecording = false
            RecorderError.recordingError
        }
    }
    
    /// Stops audio recording.
    func stopRecording() {
        audioRecorder.stop()
        isRecording = false
    }
    
    /// Returns time since recording began.
    func getDuration() -> TimeInterval {
        return audioRecorder.currentTime
    }
    
    
    /// Deletes audio files with given URL
    func deleteRecording(urlsToDelete: [URL]) {
        for url in urlsToDelete {
            print(url)
            do {
               try FileManager.default.removeItem(at: url)
            } catch {
                RecorderError.deleteError
            }
        }
    }
    
    
}
    


