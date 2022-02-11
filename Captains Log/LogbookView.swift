import SwiftUI
import RealmSwift


struct LogbookView: View {
    let logs: Results<LogEntry>
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            Text("Logbook").font(.title).bold().padding()
            
            List(logs) { log in
                NavigationLink(destination: DetailedLogView(log: log)) {
                    CardView(log: log)
                }
            }
            .listStyle(.inset)
            
            SearchBar(text: $searchText)
                .padding()
        }
    }
}


struct LogbookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogbookView(logs: logBook)
                .navigationBarHidden(true)
        }
    }
}




// CardView


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

struct CardView_Previews: PreviewProvider {
    static var log = LogEntry.tempData[0]
    static var previews: some View {
        CardView(log: log)
            .previewLayout(.fixed(width: 400, height: 60))
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
