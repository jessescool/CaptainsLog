//
//  Transcriber.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/21/22.
//

import Speech

func recognizeFile(url: URL) -> [String] {
    
    var transcript: [String] = []

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
    }
    
    print("Supports ODR: \(recognizer.supportsOnDeviceRecognition)")

    
    recognizer.recognitionTask(with: request) { (result, error) in
        guard let result = result else {
            print(error)
            return
        }
        
        print(result.bestTranscription.formattedString)
        transcript.append(result.bestTranscription.formattedString)

    }

    // contextualStrings for personal phrases...
    
}

