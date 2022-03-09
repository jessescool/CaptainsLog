import Foundation
import RealmSwift

let realm = try! Realm()

func storeLog(_ log: LogEntry) {
    let realm = try! Realm()
    
    try! realm.write {
        realm.add(log, update: .modified)
    }
  
    // for debug
    print("Pushed \(log.name) to storage.")
    print("There are now \(realm.objects(LogEntry.self).count) remaining.")
    print("Realm URL: \(realm.configuration.fileURL!)")
}

func deleteLog(primaryKey: UUID) {
    let realm = try! Realm()
    
    if let objectToDelete = realm.object(ofType: LogEntry.self, forPrimaryKey: primaryKey) {
        try! realm.write {
            print("Deleted \(objectToDelete.name)/")
            realm.delete(objectToDelete)
        }
    }
    
    // for debug
    print("There are now \(realm.objects(LogEntry.self).count) remaining")
    print("Realm URL: \(realm.configuration.fileURL!)")
}
