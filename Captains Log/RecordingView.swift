import SwiftUI
import AVFoundation
import RealmSwift
import BottomSheet

struct RecordView: View {
    @Binding var recordView: RecordSheetPosition
    @State private var isRecording: Bool = false
    @FocusState private var isNaming: Bool
    
    @StateRealmObject var newLog = LogEntry()
    @StateObject var audioRecorder = AudioRecorder()
    
    @StateObject var locationManager = LocationManager()
    
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
                Button {
                    
                    newLog.duration = audioRecorder.getDuration() // change this to inspect the audio file itself
                    audioRecorder.stopRecording() // stops recording
                    
                    isRecording = false //
                    isNaming = true
                    
                    withAnimation(.easeInOut) {
                        recordView = .top
                    }
                    
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
                        withAnimation(.easeInOut) {
                            recordView = .bottom
                        }
                                                
                        /// This task begins async transcription of the newly-created audio file.
                        ///     Breaks if...
                        ///     - Log has already been deleted by the time the task finishes.
                        Task(priority: .high) {
                            
                            do {
                                
                                // can be cleaned up...
                                let audioURL = try! newLog.audioURL!
                                
                                let transcriptor = Transcriptor(audio: audioURL, to: newLog)
                                try await transcriptor.transcribe()
                                
                                if newLog.isManaged() {
                                    try await transcriptor.pin()
                                }
                                
                            } catch {
                                print(error)
                            }
        
                        }
                        
                    }
                    .buttonStyle(.bordered)
                    
                    Button("Cancel", role: .destructive) {
                        withAnimation(.easeInOut) {
                            recordView = .bottom
                        }
                    }
                    .buttonStyle(.bordered)
                    
                }
            }
        }
        .onAppear {
        
            newLog.location["latitude"] = locationManager.lastLocation?.coordinate.latitude
            newLog.location["longitude"] = locationManager.lastLocation?.coordinate.longitude
            
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
        RecordView(recordView: .constant(.bottom))
        RecordView(recordView: .constant(.middle))
        RecordView(recordView: .constant(.top))
    }
}
