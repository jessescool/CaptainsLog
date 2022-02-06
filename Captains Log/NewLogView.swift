import SwiftUI
import RealmSwift

struct NewLogView: View {
    @ObservedRealmObject var newLog = LogEntry()
    
    var body: some View {
        VStack {
            TextField("Name", text: $newLog.name)
            TextField("Date", text: $newLog.date)
            TextField("Transcription", text: $newLog.transcription)
            Button("Add log to logbook", action: storeLog).buttonStyle(.bordered)
        }
        .padding()
    }
    
    func storeLog() {
        let realm = try! Realm()
        try! realm.write {
            realm.add(newLog)
        }
        print(realm.objects(LogEntry.self).count)
        print("Realm is at: \(realm.configuration.fileURL!)")
    }
}

struct NewLogView_Previews: PreviewProvider {
    static var previews: some View {
        NewLogView()
    }
}
