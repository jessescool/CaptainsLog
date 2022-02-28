import Speech
import RealmSwift
import UIKit

actor Transcriptor {
    
    
    
    // Contents
    let file: URL
    private(set) var enclosedTranscript: [String]?
    
    func updateTranscript() async {
        let transcription = Task(priority: .high) { () -> [String]? in
            return try? await recognize(url: self.file)
        }
        
        self.enclosedTranscript = await transcription.value
    }

    init(file: URL) {
        self.file = file
    }

}

enum TranscriptorError: Error {
    case nilRecognizer
    case notAuthorizedToRecognize
    case recognizerIsUnavailable
    case noODR
    case nilTask
    
    var message: String {
        switch self {
        case .nilRecognizer: return "Can't initialize speech recognizer"
        case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
        case .recognizerIsUnavailable: return "Recognizer is unavailable"
        case .noODR: return "Device does not support local speech recognition"
        case .nilTask: return "Task didn't work..."
        }
    }
}

/// Transcribes audio file asychronously...
func recognize(url: URL) async throws -> [String] {
    
    let recognizer: SFSpeechRecognizer = try prepareRecognizer()
    let request: SFSpeechURLRecognitionRequest = try prepareRequest(from: url)
    let recognitionResults: [SFSpeechRecognitionResult] = try await recognize(request: request, with: recognizer)
    
    var transcript = [String]()
    for result in recognitionResults {
        transcript.append(result.bestTranscription.formattedString)
    }
    
    /// Prepares and configures a SFSpeechRecognizer object
    func prepareRecognizer() throws -> SFSpeechRecognizer {
        guard let recognizer = SFSpeechRecognizer() else {
            // locale issue...
            throw TranscriptorError.nilRecognizer
        }
        
        if !recognizer.isAvailable {
            // SpeechRecognizer not available
            throw TranscriptorError.recognizerIsUnavailable
        }
        
        return recognizer
    }
    
    /// Prepares a SFSpeechURLRecognitionRequest if the SFSpeechRecognizer supports ODR, otherwise throws
    func prepareRequest(from url: URL) throws -> SFSpeechURLRecognitionRequest {
        let request = SFSpeechURLRecognitionRequest(url: url)
        request.shouldReportPartialResults = false
        request.taskHint = .dictation
        
        // contextualStrings for personal phrases...
        
        if recognizer.supportsOnDeviceRecognition {
            request.requiresOnDeviceRecognition = true
            print("Supports ODR")
        } else {
            request.requiresOnDeviceRecognition = false
//                throw TranscriptorError.noODR
        }
        
        return request
    }
    
    /// Initializes a SFSpeechRecognitionTask with a request and recognizer
    func recognize(request: SFSpeechURLRecognitionRequest, with recognizer: SFSpeechRecognizer) async throws -> [SFSpeechRecognitionResult] {
        
        // took away return
        return await withCheckedContinuation { continuation in
            
            var draft = [SFSpeechRecognitionResult]()

            recognizer.recognitionTask(with: request) { (result, error) in
                guard let result = result else {
                    print("ERROR: \(error!)")
                    // should be throwing...
                    return
                }
                
                draft.append(result)
                
                if result.isFinal {
                    continuation.resume(returning: draft)
                }
            }
        }
    }
    
    print(transcript)
    return transcript
}
