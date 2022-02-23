import Speech

enum TranscriptionistError: Error {
    case nilRecognizer
    case notAuthorizedToRecognize
    case recognizerIsUnavailable
    case noODR
    
    var message: String {
        switch self {
        case .nilRecognizer: return "Can't initialize speech recognizer"
        case .notAuthorizedToRecognize: return "Not authorized to recognize speech"
        case .recognizerIsUnavailable: return "Recognizer is unavailable"
        case .noODR: return "Device does not support local speech recognition"
        }
    }
}

func recognizeFile(url: URL) async throws -> [String] {
    
    guard let recognizer = SFSpeechRecognizer() else {
        // locale issue...
        throw TranscriptionistError.nilRecognizer
    }
    
    if !recognizer.isAvailable {
        // SpeechRecognizer not available
        throw TranscriptionistError.recognizerIsUnavailable
    }
    
    let recognitionResults: [SFSpeechRecognitionResult] = try await recognize(request: prepareRequest(from: url), with: recognizer)
    
    var transcript = [String]()
    for result in recognitionResults {
        transcript.append(result.bestTranscription.formattedString)
    }
    
    
    func prepareRequest(from url: URL) throws -> SFSpeechURLRecognitionRequest {
        let request = SFSpeechURLRecognitionRequest(url: url)
        request.shouldReportPartialResults = false
        request.taskHint = .dictation
        
        if recognizer.supportsOnDeviceRecognition {
            request.requiresOnDeviceRecognition = true
            print("Supports ODR")
        } else {
            throw TranscriptionistError.noODR
        }
        
        return request
    }
    
    func recognize(request: SFSpeechURLRecognitionRequest, with recognizer: SFSpeechRecognizer) async -> [SFSpeechRecognitionResult] {
        
        return await withCheckedContinuation { continuation in
            
            var draft = [SFSpeechRecognitionResult]()

            recognizer.recognitionTask(with: request) { (result, error) in
                guard let result = result else {
                    print("ERROR: \(error!)")
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

// I want this to return a String....



// contextualStrings for personal phrases...
