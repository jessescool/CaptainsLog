//
//  Transcriber.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/21/22.
//

import Speech

func recognizeFile(url: URL) async -> [String] {
    // should throw errors....
    guard let recognizer = SFSpeechRecognizer() else {
        // Not supported in user's locale
        return ["Error"]
    }
    
    if !recognizer.isAvailable {
        // SpeechRecognizer not available
        return ["Error"]
    }
    
    let request = SFSpeechURLRecognitionRequest(url: url)
    request.shouldReportPartialResults = false
    request.taskHint = .dictation
    
    if recognizer.supportsOnDeviceRecognition {
        request.requiresOnDeviceRecognition = true
        print("Supports ODR")
    }
    
    // maybe should be async....
    func recognize(request: SFSpeechURLRecognitionRequest, with recognizer: SFSpeechRecognizer) async -> [String] {
        
        return await withCheckedContinuation { continuation in
            
            var transcript = [String]()

            recognizer.recognitionTask(with: request) { (result, error) in
                guard let result = result else {
                    print("ERROR: \(error!)")
                    return
                }
                
                transcript.append(result.bestTranscription.formattedString)
                
                if result.isFinal {
                    continuation.resume(returning: transcript)
                }
            }
        }
    }
    
    return await recognize(request: request, with: recognizer)
}

// I want this to return a String....



// contextualStrings for personal phrases...
