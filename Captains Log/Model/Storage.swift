import Foundation
import RealmSwift

let realm = try! Realm()
var logBook = realm.objects(LogEntry.self)


// REALM LISTENER
// Observe realm notifications. Keep a strong reference to the notification token
// or the observation will stop.
//let token = realm.observe { notification, realm in
//    // `notification` is an enum specifying what kind of notification was emitted
//    viewController.updateUI()
//}
// ...
// Later, explicitly stop observing.
//token.invalidate()


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

//func deleteLog(primaryKey: UUID) {
//    let realm = try! Realm()
//    if let objectToDelete = realm.object(ofType: LogEntry.self, forPrimaryKey: primaryKey) {
//        var safeObject = Array<LogEntry>()
//        safeObject.append(objectToDelete)
//        print(type(of: safeObject))
//        print(safeObject[0])
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
//            try! realm.write {
//                realm.delete(safeObject[0])
//            }
//        }
//    }
//}

func deleteLog(primaryKey: UUID) {
    let realm = try! Realm()
    if let objectToDelete = realm.object(ofType: LogEntry.self, forPrimaryKey: primaryKey) {
        try! realm.write {
            realm.delete(objectToDelete)
        }
    }
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
