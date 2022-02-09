import SwiftUI
import RealmSwift

struct RecordingView: View {
    @ObservedRealmObject var newLog = LogEntry()
    
    var body: some View {
        VStack {
            TextField("Name", text: $newLog.name)
            TextField("Date", text: $newLog.date)
            TextField("Transcription", text: $newLog.transcription)
            Button("Add log to logbook") {
                pushToStorage(log: newLog)
            }
                .buttonStyle(.bordered)
        }
        .padding()
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordingView()
    }
}
