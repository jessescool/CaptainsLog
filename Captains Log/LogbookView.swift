import SwiftUI
import RealmSwift

struct LogbookView: View {
    @ObservedResults(LogEntry.self) var logs
    @State private var searchText = ""
    
    var sortedLogs: Results<LogEntry> {
        if searchText.isEmpty {
            return logs
        } else {
            // obviously not final
            lazy var matches: Results<LogEntry> = {
                logs.where {
                    $0.name.contains(searchText) || $0.transcription.contains(searchText)
                }
            }()
            return matches
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    // something here
                } label: {
                    Image(systemName: "pencil.and.outline")
                        .padding(.leading, 25)
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }
                
                Spacer()
                Text("Logbook").font(.title).bold()
                Spacer()
                
                Button {
                    // filter options here
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .padding(.trailing, 25)
                        .foregroundColor(.blue)
                        .imageScale(.large)
                }

            }
            .padding()

            
            List {
                ForEach(sortedLogs) { log in
                    NavigationLink(destination: DetailedLogView(log: log)) {
                        CardView(log: log)
                    }
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
            LogbookView()
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
