import SwiftUI
import RealmSwift

struct DetailedLogView: View {
    @ObservedRealmObject var log: LogEntry
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Specs")) {
                    HStack {
                        Label("Date", systemImage: "star")
                        Spacer()
                        Text("\(log.date.formatted(date: .complete, time: .shortened))")
                    }
                    HStack {
                        Label("Duration", systemImage: "clock")
                        Spacer()
                        Text("\(log.duration)")
                    }
                    HStack {
                        Label("Location", systemImage: "pin")
                        Spacer()
                        Text("\(log.location)")
                    }
                }
                Section(header: Text("Transcription")) {
                    Text(log.transcription)
                    Text(log.id.uuidString)
                }
                
            }
            .listStyle(.inset)
            
            Button("Edit...") {
                // edit here...
            }
            .buttonStyle(.bordered)
            
            Button("Delete", role: .destructive) {
                presentationMode.wrappedValue.dismiss()
                deleteLog(primaryKey: log.id)
            }
            .buttonStyle(.bordered)
            
        }
        .navigationTitle(log.name)
    }
}

struct DetailedLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailedLogView(log: LogEntry.tempData[0])
        }
    }
}
