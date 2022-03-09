import SwiftUI
import AVFoundation
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @State private var isRecording: Bool = false
    @FocusState private var isNaming: Bool
    
    @StateRealmObject var newLog = LogEntry()
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
            
            // Stop recording button
            if isRecording {
                Button(role: .destructive) {
                    
                    newLog.duration = audioRecorder.getDuration()
                    audioRecorder.stopRecording()
                    
                    isRecording = false
                    isNaming = true
                } label: {
                    Image(systemName: "stop.circle")
                }
                .buttonStyle(RecordButton())
            } else {
                // Enter name
                TextField("Name", text: $newLog.name)
                    .textFieldStyle(.roundedBorder)
                    .padding(.horizontal)
                    .focused($isNaming)
                
                // Confirm or Cancel
                HStack {
                    Button("Confirm") {
                        
                        // giving default name
                        if newLog.name.isEmpty {
                            newLog.name = "Log \(realm.objects(LogEntry.self).count + 1)"
                        }
                        
                        // saves log to realm
                        storeLog(newLog)
                        
                        // hides sheet
                        showingRecordView = false
                                                
                        /// This task begins async transcription of the newly-created audio file.
                        ///     Breaks if...
                        ///     - Log has already been deleted by the time the task finishes.
                        Task(priority: .high) {
                            
                            let audioURL = try! newLog.audioURL!
                            let transcriptor = Transcriptor(file: audioURL)
                                                        
                            do {
                                try await transcriptor.transcribe()
                                try await pinTranscript(transcriptor.returnTranscript(), to: newLog)
                            } catch {
                                print(error)
                            }
                            

                            
                        }
                        
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Cancel", role: .destructive) {
                        showingRecordView = false
                    }
                    .buttonStyle(.bordered)
                    
                }
                .padding(.bottom)
            }
        }
        .padding()
        
        .onAppear {
            
            let newLogRecordingPath = documentsPath().appendingPathComponent("\(newLog.id.uuidString).m4a")

            do {
                try audioRecorder.prepare(filepath: newLogRecordingPath)
            } catch {
                print(error)
            }
            
            isRecording = true
            audioRecorder.startRecording()
            
        }
    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(showingRecordView: .constant(true))
    }
}
