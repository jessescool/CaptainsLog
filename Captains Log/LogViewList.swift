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
            .navigationBarHidden(true)
        }
    }
}

struct LogView_Previews: PreviewProvider {
    static var previews: some View {
            LogViewList(logs: LogEntry.tempData)
    }
}
