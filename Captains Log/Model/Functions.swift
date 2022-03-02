import Foundation
import RealmSwift

// Thanks @twostraws
public func documentsPath() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return paths[0]
}

enum FileError: Error {
    case DNE
}

// Pulls audio by UUID from documents folder
func getAudioURL(file id: UUID) throws -> URL {
    // does this work if URL does not exist?
    let potentialPath: URL = documentsPath().appendingPathComponent("\(id.uuidString).m4a")
    
    // to be modified later on... perhaps can produce an AVAudioFile object?
    func isAudioFile(url: URL) -> Bool {
        if url.isFileURL {
            return true
        } else {
            return false
        }
    }
    
    guard isAudioFile(url: potentialPath) else {
        throw FileError.DNE
    }
    
    return potentialPath
}

// NOT WORKING YET, BUT IMPORTANT
func recognizeAudio(@ThreadSafe log: LogEntry?) async {
    guard let log = log else {
        return
    }
    
    let audioURL = try! log.audioURL!
    let transcriptor = Transcriptor(file: audioURL)
    
    do {
        try await transcriptor.recognize()
        try await print(transcriptor.getTranscript())
    } catch {
        print(error)
    }
    
    let potentialTranscript: String? = try? await transcriptor.getTranscript()
    
    // Where it begins to get thread-unsafe and sketch...
    let thawedLog = log.thaw()
    if let thawedLog = thawedLog {
        try! realm.write {
            thawedLog.transcript = potentialTranscript
        }
    }
    
}
