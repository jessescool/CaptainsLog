import Foundation
import RealmSwift

let realm = try! Realm()
var logBook = realm.objects(LogEntry.self)

func pushToStorage(log: LogEntry) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(log, update: .modified)
    }
    
    print("Pushed \(log.name) to storage")
    print(realm.objects(LogEntry.self).count)
    print("Realm URL: \(realm.configuration.fileURL!)")
    print(logBook)
}

func deleteLog(primaryKey: UUID) {
    let realm = try! Realm()
//    if let objectToDelete = realm.object(ofType: LogEntry.self, forPrimaryKey: primaryKey) {
//        var safeObject = Array<LogEntry>()
//        safeObject.append(objectToDelete)
//        print(type(of: safeObject))
//        print(safeObject[0])
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
//            try! realm.write {
//                realm.delete(safeObject[0])
//            }
//        }
//    }
}

/*
 nagini
 himself
 ring
 book
 cup
 locket
 diadem
 
 */
