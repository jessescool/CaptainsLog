import Foundation
import RealmSwift

class LogEntry: Object, Identifiable {
    
    // Initialized upon creation
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var date: Date = Date.now
    @Persisted var location: Double? = 1.21

    // Initialized immediately before log is written to realm
    @Persisted var name: String = ""
    @Persisted var duration: TimeInterval = 0.0
    
    @Persisted var transcript: String?

    var audioURL: URL? {
        get throws {
            try getAudioURL(file: self.id)
        }
    }
    
    // convenience init due to Realm's Object.init()
    convenience init(name: String = "") {
        self.init() // for Object.init()
    
        self.id = UUID()
        self.name = name // only property to set...
        self.date = Date.now
        self.location = 1.21
        self.duration = 0.0
    }
}
