import SwiftUI
import AVFoundation
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @StateRealmObject var newLog = LogEntry()
    @State private var isRecording: Bool = false
    @FocusState private var isNaming: Bool
    
    @StateObject var audioRecorder = AudioRecorder()
    
    var body: some View {
        VStack {
            
            if isRecording {
                Text("Recording...").font(.title).bold().padding(.top)
            } else if newLog.name.isEmpty {
                Text("Name").font(.title).bold().padding(.top).foregroundColor(.secondary)
            } else {
                Text(newLog.name).font(.title).bold().padding(.top)
            }
            
            Spacer()
            
            if isRecording {
                Button(role: .destructive) {
                    
                    audioRecorder.stopRecording()
                    
                    isRecording = false
                    isNaming = true
                } label: {
                    Image(systemName: "stop.circle")
                }
                .buttonStyle(RecordButton())
            } else {
                TextField("Name", text: $newLog.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .focused($isNaming)
                HStack {
                    Button("Confirm") {
                        if newLog.name.isEmpty {
                            let realm = try! Realm()
                            newLog.name = "Log \(realm.objects(LogEntry.self).count + 1)"
                        }
                        store(log: newLog)
                        
                        Task(priority: .high) {
                            do {
                                
                                // NOT AT ALL SAFE, breaks on log delete before transcription finishes.
                                let thawedLog = newLog.thaw()
                                let transcription: String = try await recognizeFile(url: getAudioRecording(id: newLog.id)).joined(separator: ". ")
                                
                                let realm = try! await Realm()
                                try! realm.write {
                                    thawedLog?.transcription = transcription
                                }
                                
                            } catch {
                                print("Unexpected error: \(error)")
                            }
                        }
                        
                        showingRecordView = false
                    }.buttonStyle(.bordered)
                    
                    Button("Cancel", role: .destructive) {
                        showingRecordView = false
                    }.buttonStyle(.bordered)
                }
                .padding(.bottom)
            }
        }
        .padding()
        
        .onAppear {
            isRecording = true
            
            // testing...
            audioRecorder.recordingName = newLog.id.uuidString // probably not the best way... maybe a lazy property in recorder class
            audioRecorder.startRecording()
        }

    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(showingRecordView: .constant(true))
    }
}
