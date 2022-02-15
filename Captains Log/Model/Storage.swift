import Foundation
import RealmSwift

let realm = try! Realm()

func pushToStorage(log: LogEntry) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(log, update: .modified)
    }
  
    // for debug
    print("Pushed \(log.name) to storage")
    print(realm.objects(LogEntry.self).count)
    print("Realm URL: \(realm.configuration.fileURL!)")
    print()
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
