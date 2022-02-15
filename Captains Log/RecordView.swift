import SwiftUI
import AVFoundation
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @StateRealmObject var newLog = LogEntry()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack {
            Text("New Log").font(.title).bold().padding(.top)
            
            if isRecording {
                Text("I am recording!")
            } else {
                Text("Not recording...")
            }
            
            VStack {
                Text(speechRecognizer.transcript)
            }
                .padding()

            
            Spacer()
            
            if isRecording {
                Button("Stop recording", role: .destructive) {
                    speechRecognizer.stopTranscribing()
                    isRecording = false
                }.buttonStyle(.borderedProminent)
            } else {
                TextField("Name", text: $newLog.name)
                HStack {
                    Button("Confirm") {
                        newLog.transcription = speechRecognizer.transcript
                        pushToStorage(log: newLog)
                        
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
