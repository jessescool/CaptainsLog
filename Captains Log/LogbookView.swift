import SwiftUI
import RealmSwift

struct LogbookView: View {
    var logs: Results<LogEntry>
    @State private var searchText = ""
    
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
