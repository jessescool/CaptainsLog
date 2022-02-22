import SwiftUI
import AVFoundation
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @StateRealmObject var newLog = LogEntry()
    @StateObject var speechRecognizer = SpeechRecognizer()
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
            
            Text(speechRecognizer.transcript)
                .padding()

            Spacer()
            
            if isRecording {
                Button(role: .destructive) {
                    speechRecognizer.stopTranscribing()
                    
                    // testing...
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
                        newLog.transcription = speechRecognizer.transcript
                        if newLog.name.isEmpty {
                            let realm = try! Realm()
                            newLog.name = "Log \(realm.objects(LogEntry.self).count + 1)"
                        }
                        store(log: newLog)
                        
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
            speechRecognizer.reset()
            speechRecognizer.transcribe()
            
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
