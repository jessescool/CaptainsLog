import Foundation

struct LogEntry: Identifiable {
    let id: UUID
    var name: String
    var date: Date
    var duration: Double
    var location: [Double] // or CLLocation
    var transcription: String
    
    init(id: UUID = UUID(), name: String, date: Date, duration: Double, location: [Double], transcription: String) {
        self.id = id
        self.name = name
        self.date = Date.now
        self.duration = duration
        self.location = location
        self.transcription = transcription
    }
}

// temporary data for preview purposes
extension LogEntry {
    static var tempData: [LogEntry] {
        [
            LogEntry(name: "Day 1", date: Date.now, duration: 22.60, location: [123.4, 55.6], transcription: "I shot the sherrif"),
            LogEntry(name: "Day 2", date: Date.now, duration: 23.60, location: [123.4, 55.6], transcription: "And I didn't need no deputy"),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif..."),
            LogEntry(name: "Day 3", date: Date.now, duration: 26.60, location: [12, 55.6], transcription: "I shot the sherrif...")
        ]
    }
}
