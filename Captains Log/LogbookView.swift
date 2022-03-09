import SwiftUI
import RealmSwift

struct LogbookView: View {
    @ObservedResults(LogEntry.self) var logs
    @State private var filtering = false
    @State private var searchText = ""
    @State private var sortedBy: String = UserDefaults.standard.string(forKey: "defaultSort") ?? "date"
    @State private var sortOrderAscending: Bool = true
    
    var relevantLogs: Results<LogEntry> {
        if searchText.isEmpty {
            return logs.sorted(byKeyPath: sortedBy, ascending: sortOrderAscending)
        } else {
            // obviously not final
            lazy var matches: Results<LogEntry> = {
                logs.where {
                    $0.name.contains(searchText)
                }
            }()
            return matches.sorted(byKeyPath: sortedBy, ascending: sortOrderAscending)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                
                Button {
                    sortOrderAscending.toggle()
                } label: {
                    Image(systemName: sortOrderAscending ? "arrow.down" : "arrow.up")
                        .navBarIcon(withPadding: .leading)
                }
                
                Spacer()
                Text("Logbook").font(.title).bold()
                Spacer()
                
                Button {
                    filtering.toggle()
                } label: {
                    Image(systemName: "line.3.horizontal.decrease.circle")
                        .navBarIcon(withPadding: .trailing)
                }
                
            }
            .confirmationDialog("Sort logs by...", isPresented: $filtering, titleVisibility: .visible) {
                
                Button(Sort.name.rawValue) { sortedBy = Sort.name.rawValue }
                Button(Sort.date.rawValue) { sortedBy = Sort.date.rawValue }
                Button(Sort.duration.rawValue) { sortedBy = Sort.duration.rawValue }
                
            }
            .padding()
            
            List(relevantLogs) { log in
                NavigationLink(destination: DetailedLogView(log: log).id(UUID())) {
                    CardView(log: log)
                }
            }
            .listStyle(.inset)
            .animation(.default, value: 1) // uncelar...
            
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
