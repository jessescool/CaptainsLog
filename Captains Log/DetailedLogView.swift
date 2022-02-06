import SwiftUI

struct DetailedLogView: View {
    let log: LogEntry
    var body: some View {
        List {
            Section(header: Text("Specs")) {
                HStack {
                    Label("Date", systemImage: "star")
                    Spacer()
                    Text("\(log.date)")
                }
                HStack {
                    Label("Duration", systemImage: "clock")
                    Spacer()
                    Text("\(log.duration)")
                }
                HStack {
                    Label("Location", systemImage: "clock")
                    Spacer()
                    Text("\(log.location[0]), \(log.location[1])")
                }
            }
            Section(header: Text("Transcription")) {
                Text(log.transcription)
            }
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
