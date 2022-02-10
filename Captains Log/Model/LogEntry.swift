import Foundation
import RealmSwift

class LogEntry: Object, Identifiable {
    @Persisted(primaryKey: true) var id: UUID = UUID()
    @Persisted var name: String = ""
    @Persisted var date: Date = Date.now
    @Persisted var duration: Double = 0.0
    @Persisted var location: Double = 0.0
    @Persisted var transcription: String = ""
    
    convenience init(id: UUID = UUID(), name: String = "", date: Date = Date.now, duration: Double = 0.0, location: Double = 0.0, transcription: String = "") {
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
            LogEntry(name: "Foodstuffs", date: Date.init(timeIntervalSinceNow: 86400), duration: 18.45, location: 123.4, transcription: "We ate cake, brownies, and I talked with Cinderella. Her shoe fit, surprisingly. Her feet were actually the wrong size."),
            LogEntry(name: "The Sherrif", date: Date.init(timeIntervalSinceNow: 1888), duration: 9.8, location: 123.4, transcription: "I shot the sherrif, after listening to Bob for a while. Jimi Hendrix as a close second."),
            LogEntry(name: "Coffee and Existentialism", date: Date.init(timeIntervalSinceNow: 86400), duration: 34.5, location: 123.4, transcription: "My coffee was sour this afternoon, and I questionining everything, happily poured it out all over my lap"),
            LogEntry(name: "DAWN FM", date: Date.init(timeIntervalSinceNow: 180000), duration: 11.56, location: 123.4, transcription: "The Weeknd's DAWN FM album is a hard-hitting album for real existentialists. Many critics rate this album lower than After Hours. I agree with them, but the album is still FYRE."),
            LogEntry(name: "Elements", date: Date.init(timeIntervalSinceNow: 18808), duration: 18.69, location: 123.4, transcription: "Hydrogren Helium Lithium Breyllium, or however you spell it."),
            LogEntry(name: "Cabesita", date: Date.init(timeIntervalSinceNow: 12020), duration: 10.11, location: 123.4, transcription: "Cabesita, is the place I go at night."),
            LogEntry(name: "Noemi", date: Date.init(timeIntervalSinceNow: 1000000), duration: 2.11, location: 123.4, transcription: "Noemi Noemi Noemi Noemi Noemi Noemi, I am in love with. Ursa Major played a huge role in my childhood.")
        ]
    }
}
