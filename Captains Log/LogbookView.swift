import SwiftUI
import RealmSwift


struct LogbookView: View {
    let logs: Results<LogEntry>
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            HStack {
                Image(systemName: "pencil")
                    .padding(.leading, 25)
                    .foregroundColor(.blue)
                
                Spacer()
                Text("Logbook").font(.title).bold()
                Spacer()
                
                Image(systemName: "line.3.horizontal.decrease.circle")
                    .padding(.trailing, 25)
                    .foregroundColor(.blue)
            }
            .padding()

            
            List(sortedLogs) { log in
                NavigationLink(destination: DetailedLogView(log: log)) {
                    CardView(log: log)
                }
            }
            .listStyle(.inset)
            
            SearchBar(text: $searchText)
                .padding()
        }
    }
    
    var sortedLogs: Results<LogEntry> {
        if searchText.isEmpty {
            return logs
        } else {
            // obviously not final
            lazy var matches: Results<LogEntry> = {
                realm.objects(LogEntry.self).where {
                    $0.name == searchText
                }
            }()
            return matches
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

struct LogbookView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LogbookView(logs: logBook)
                .navigationBarHidden(true)
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
