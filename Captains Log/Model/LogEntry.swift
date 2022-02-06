import Foundation
import RealmSwift

let realm = try! Realm()
let importedLogs = realm.objects(LogEntry.self)

class LogEntry: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String = ""
    @Persisted var date: String = ""
    @Persisted var duration: Double = 0.0
    @Persisted var location: Double = 0.0
    @Persisted var transcription: String = ""
    
    convenience init(id: UUID = UUID(), name: String = "", date: String = "", duration: Double = 0.0, location: Double = 0.0, transcription: String = "") {
        self.init()
        self.name = name
        self.date = date
        self.duration = duration
        self.location = location
        self.transcription = transcription
        // I'm not sure if this is the right situation...
    }
}

// temporary data for preview purposes
extension LogEntry {
    static var tempData: [LogEntry] {
        [
            LogEntry(name: "Day 1", date: "Monday", duration: 22.60, location: 123.4, transcription: "I shot the sherrif"),
            LogEntry(name: "Day 2", date: "Tuesday", duration: 23.60, location: 123.4, transcription: "And I didn't need no deputy"),
            LogEntry(name: "Day 3", date: "Wednesday", duration: 26.60, location: 123.4, transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: "Thursday", duration: 26.60, location: 123.4, transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: "Friday", duration: 26.60, location: 123.4, transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: "Saturday", duration: 26.60, location: 123.4, transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: "Sunday", duration: 26.60, location: 123.4, transcription: "I shot the sherrif...")
        ]
    }
}

let logBook: [LogEntry] = importedLogs.shuffled()
// why shuffled? IDK.
