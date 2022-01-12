import Foundation

struct LogEntry: Identifiable {
    let id: UUID
    var name: String
    var date: String
    var duration: Double
    var location: [Double]
    var transcription: String
    
    init(id: UUID = UUID(), name: String, date: String, duration: Double, location: [Double], transcription: String) {
        self.id = id
        self.name = name
        self.date = date
        self.duration = duration
        self.location = location
        self.transcription = transcription
    }
}

extension LogEntry {
    static var data: [LogEntry] {
        [
            LogEntry(name: "Day 1", date: "Monday", duration: 22.60, location: [123.4, 55.6], transcription: "I shot the sherrif"),
            LogEntry(name: "Day 2", date: "Tuesday", duration: 23.60, location: [123.4, 55.6], transcription: "And I didn't need no deputy"),
            LogEntry(name: "Day 3", date: "Wednesday", duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif...")
        ]
    }
}

extension LogEntry {
    
    struct Data {
        var name: String = ""
        var date: String = ""
        var duration: Double = 0.00
        var location: [Double] = [0.00, 0.00]
        var transcription: String = ""
    }
    
    var data: Data {
        return Data(name: name, date: date, duration: duration, location: location, transcription: transcription)
        // might want to make location (exact) and location (inputted) two different things...
    }
    
}
