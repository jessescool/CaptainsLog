import SwiftUI
import AVFoundation
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @StateRealmObject var newLog = LogEntry()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording: Bool = false
    @FocusState private var isNaming: Bool
    
    var body: some View {
        VStack {
            Text("New Log").font(.title).bold().padding(.top)
            
            if isRecording {
                Text("I am recording!").padding()
            } else {
                Text("Not recording...").padding()
            }
            
            VStack {
                Text(speechRecognizer.transcript)
            }
                .padding()

            
            Spacer()
            
            if isRecording {
                Button(role: .destructive) {
                    speechRecognizer.stopTranscribing()
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
        }

    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(showingRecordView: .constant(true))
    }
}
