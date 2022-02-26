import Foundation

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
