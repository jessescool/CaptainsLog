import Speech
import RealmSwift

enum GeneralError: Error {
    case deletedLog
}

actor Transcriptor {
    
    enum TranscriptorError: Error {
        case nilRecognizer
        case notAuthorizedToRecognize
        case recognizerIsUnavailable
        case noODR
        case nilTask
        case nilTranscript
        
        var message: String {
            switch self {
            case .nilRecognizer: return "Can't initialize speech recognizer"
            case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
            case .recognizerIsUnavailable: return "Recognizer is unavailable"
            case .noODR: return "Device does not support local speech recognition"
            case .nilTask: return "Task didn't work..."
            case .nilTranscript: return "Enclosed transcript was empty. Please call makeTranscript()."
            }
        }
    }

    let audioFile: URL
    let destination: LogEntry
    private var enclosedTranscript: [String]? // Optional string to preserve data, although should perhaps be [SFSpeechRecognitionResult]?

    init(audio: URL, to destination: LogEntry) {
        self.audioFile = audio
        self.destination = destination
    }
    
    
    /// If `enclosedTranscript` contains a transcript, this function pins its value to the destination thread-safe log entry object.
    /// Throws errors if...
    ///     - log has been deleted
    ///     - transcriptor contains no transcript

    func pin() throws {
        @ThreadSafe var log: LogEntry? = destination
        
        guard let log = log else {
            throw GeneralError.deletedLog
        }
        
        guard let enclosedTranscript = enclosedTranscript else {
            throw TranscriptorError.nilTranscript
        }
        
        let smoothedTranscript = enclosedTranscript.joined(separator: " ")
        
        let realm = try! Realm()
        try! realm.write {
            log.transcript = smoothedTranscript
        }
        
    }
    
    
    /// Transcribes audio file `audioFile` asychronously and writes to `enclosedTranscript`.
    func transcribe() async throws {
        let url = self.audioFile
        
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
            return try await withCheckedThrowingContinuation { continuation in
                
                var draft = [SFSpeechRecognitionResult]()

                recognizer.recognitionTask(with: request) { (result, error) in
                    guard let result = result else {
                        // guard expression stops continuation leakage.
                        continuation.resume(throwing: TranscriptorError.nilTask)
                        return
                    }
                    
                    draft.append(result)
                    
                    if result.isFinal {
                        continuation.resume(returning: draft)
                    }
                }
                
            }
            
        }
        
        print("Returning: '\(transcript)'")
        self.enclosedTranscript = transcript
    }
}
