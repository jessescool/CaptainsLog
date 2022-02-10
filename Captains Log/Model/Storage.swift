import Foundation
import RealmSwift

let realm = try! Realm()
var logBook: [LogEntry] = Array(realm.objects(LogEntry.self))

func pushToStorage(log: LogEntry) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(log, update: .modified)
    }
    
    print("Pushed \(log.name) to storage")
    print(realm.objects(LogEntry.self).count)
    print("Realm URL: \(realm.configuration.fileURL!)")
}
