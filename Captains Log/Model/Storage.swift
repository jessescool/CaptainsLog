import Foundation
import RealmSwift

let realm = try! Realm()

// subject to change when users can create multiple logbooks
var logbook = realm.objects(LogEntry.self)
//var logbook: List<LogEntry> {
//    var book = List<LogEntry>()
//    for log in allLogs {
//        book.append(log)
//    }
//    return book
//}

func pushToStorage(log: LogEntry) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(log, update: .modified)
    }
    
    print("Pushed \(log.name) to storage")
    print(realm.objects(LogEntry.self).count)
    print("Realm URL: \(realm.configuration.fileURL!)")
    print(logbook)
}

func deleteLog(primaryKey: UUID) {
    let realm = try! Realm()
    if let objectToDelete = realm.object(ofType: LogEntry.self, forPrimaryKey: primaryKey) {
        try! realm.write {
            realm.delete(objectToDelete)
        }
    }
    print("Not working...")
} // not working
