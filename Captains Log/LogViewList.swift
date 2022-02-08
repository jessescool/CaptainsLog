import SwiftUI

struct LogViewList: View {
    let logs: [LogEntry]
    var body: some View {
        NavigationView {
            List(logs) { log in
                NavigationLink(destination: DetailedLogView(log: log)) {
                    CardView(log: log)
                }
            }
            .listStyle(.inset)
            .navigationBarHidden(true)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
            LogViewList(logs: LogEntry.tempData)
    }
}

/**
    .automatic
    .grouped
    .inset
    .insetGrouped
    .plain
    .sidebar
*/
