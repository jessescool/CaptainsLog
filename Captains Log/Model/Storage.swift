//
//  Storage.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/6/22.
//

import Foundation
import RealmSwift

let realm = try! Realm()
let importedLogs = realm.objects(LogEntry.self)
let logBook: [LogEntry] = importedLogs.shuffled()

func pushToStorage(log: LogEntry) {
    let realm = try! Realm()
    try! realm.write {
        realm.add(log, update: .modified)
    }
    print(realm.objects(LogEntry.self).count)
    print("Realm is at: \(realm.configuration.fileURL!)")
}
