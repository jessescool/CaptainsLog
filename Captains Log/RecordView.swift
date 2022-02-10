import SwiftUI
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @ObservedRealmObject var newLog = LogEntry()
    
    var body: some View {
        VStack {
            Text("New Log").font(.title).bold().padding(.top)
            Spacer()
            TextField("Name", text: $newLog.name)
            TextField("Transcription", text: $newLog.transcription)
            
            Button("Add log to logbook") {
                pushToStorage(log: newLog)
                showingRecordView = false
            }
                .buttonStyle(.bordered)
            
            Button("Cancel", role: .destructive) {
                showingRecordView = false
            }
            Spacer()
        }
        .padding()
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(showingRecordView: .constant(true))
    }
}
