import SwiftUI
import RealmSwift

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
                        Text("\(log.location)")
                    }
                }
                Section(header: Text("Transcription")) {
                    if isEditing {
                        TextEditor(text: $log.transcription)
                            .foregroundColor(.gray)
                    } else {
                        Text(log.transcription)

                    }
                }
                
            }
            .listStyle(.inset)
            
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
    }
}

struct DetailedLogView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DetailedLogView(log: LogEntry.tempData[0])
        }
    }
}
