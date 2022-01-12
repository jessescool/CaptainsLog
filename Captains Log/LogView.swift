import SwiftUI

struct LogView: View {
    let logs: [LogEntry]
    var body: some View {
        NavigationView {
            List {
                ForEach(logs) { log in
                    NavigationLink(destination: DetailedLogView(log: log)) {
                        CardView(log: log)
                    }
                }
            }
            .navigationTitle("Logbook")
            .navigationBarItems(trailing: Button(action: {}) {
                Image(systemName: "plus")
            })
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
            LogView(logs: LogEntry.data)
    }
}
