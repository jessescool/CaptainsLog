//
//  Transcriber.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/21/22.
//

import Speech

func recognizeFile(url: URL) -> [String] {
    
    guard let recognizer = SFSpeechRecognizer() else {
        // Not supported in user's locale
        return ["nah"]
    }
    
    if !recognizer.isAvailable {
        // SpeechRecognizer not available
        return ["nah"]
    }
    
    
    
    let request = SFSpeechURLRecognitionRequest(url: url)
    request.shouldReportPartialResults = false
    request.taskHint = .dictation
    
    if recognizer.supportsOnDeviceRecognition {
        request.requiresOnDeviceRecognition = true
    }
    
    print("Supports ODR: \(recognizer.supportsOnDeviceRecognition)")

    func recognize(request: SFSpeechURLRecognitionRequest, with recognizer: SFSpeechRecognizer) -> [String] {
        var transcript: [String] = []
        
        recognizer.recognitionTask(with: request) { (result, error) in
            guard let result = result else {
                print(error)
                return
            }
            
            print(result.bestTranscription.formattedString)
            transcript.append(result.bestTranscription.formattedString)

        }
        
        return transcript
    }
    
    return recognize(request: request, with: recognizer)
}



// contextualStrings for personal phrases...
