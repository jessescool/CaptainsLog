import SwiftUI
import RealmSwift
import SwiftySound // for now...

struct DetailedLogView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedRealmObject var log: LogEntry // not sure if this is final
    @State private var isEditing: Bool = false
        
    var body: some View {
        VStack {
            List {
                Section(header: Text("Info")) {
                    HStack {
                        Label("Date", systemImage: "calendar")
                        Spacer()
                        if !isEditing {
                            Text("\(log.date.formatted(date: .numeric, time: .shortened))")
                        } else {
                            DatePicker("Please enter a date", selection: $log.date)
                                .labelsHidden()
                        }
                    }
                    HStack {
                        Label("Duration", systemImage: "hourglass.tophalf.filled")
                        Spacer()
                        Text("\(log.duration, specifier: "%.2f")s")
                    }
                    HStack {
                        Label("Location", systemImage: "mappin.and.ellipse")
                        Spacer()
                        Text("Location")
                    }
                }
                
                Section(header: Text("Transcription")) {
                    if let transcript = log.transcript {
                        Text(transcript)
                    } else {
                        Text("No transcript available")
                    }
                }
                
            }
            .listStyle(.inset)

            Spacer()
            
            Button {
                do {
                    try Sound.play(url: log.audioURL!)
                } catch {
                    print(error)
                }
                
            } label: {
                Image(systemName: "play")
                    .imageScale(.large)
            }
            
            Spacer()
                        
            VStack {
                
                Button(isEditing ? "Done" : "Edit...") {
                    isEditing.toggle()
                }
                .buttonStyle(.bordered)
                
                if !isEditing {
                    Button("Delete", role: .destructive) {
                        dismiss()
                        deleteLog(primaryKey: log.id)
                    }
                    .buttonStyle(.bordered)
                }
            }
            .padding()
            
        }
        .navigationTitle(log.name)
        
        .onDisappear {
            // might be naive...
            Sound.stopAll()
        }
        
        .task {
            if log.transcript == nil {
                
//                let audioURL = try! log.audioURL!
//                let transcriptor = Transcriptor(file: audioURL)
//
//                do {
//                    try await transcriptor.transcribe()
//                } catch {
//                    print(error)
//                }
            
            }
        }
        
    }
}

struct DetailedLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailedLogView(log: LogEntry(name: "Foodstuffs"))
        }
    }
}
