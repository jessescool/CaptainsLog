import SwiftUI

struct CardView: View {
    let log: LogEntry
    var body: some View {
        VStack(alignment: .leading) {
            Text(log.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(log.date.formatted(date: .abbreviated, time: .omitted))", systemImage: "calendar")
                Spacer()
                Label("\(log.duration, specifier: "%.2f")", systemImage: "hourglass.tophalf.filled")
            }
        }
        .padding()
        .foregroundColor(Color(hue: 0.576, saturation: 0.672, brightness: 0.568))
    }
}

struct LogbookView: View {
    let logs: [LogEntry]
    @State private var searchText = ""
    
    var body: some View {
        List(logs) { log in
            NavigationLink(destination: DetailedLogView(log: log)) {
                CardView(log: log)
            }
        }
        .listStyle(.inset)
        .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search for a log, phrase, person...")
    }
}

struct CardView_Previews: PreviewProvider {
    static var log = LogEntry.tempData[0]
    static var previews: some View {
        CardView(log: log)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}

struct LogbookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogbookView(logs: LogEntry.tempData)
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Logbook")
        }
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
