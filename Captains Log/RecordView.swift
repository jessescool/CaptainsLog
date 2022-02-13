import SwiftUI
import AVFoundation
import RealmSwift

struct RecordView: View {
    @Binding var showingRecordView: Bool
    @ObservedRealmObject var newLog = LogEntry()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State private var isRecording: Bool = false
    
    var body: some View {
        VStack {
            Text("New Log").font(.title).bold().padding(.top)
            Spacer()
            
            VStack {
                if isRecording {
                    Text("I am recording!")
                } else {
                    Text("Not recording...")
                }
                Text(speechRecognizer.transcript).font(.headline).padding()
                Text(newLog.date.formatted(date: .numeric, time: .shortened))
                Text("\(newLog.location)")
                TextField("Name", text: $newLog.name)
                TextField("Transcription", text: $newLog.transcription)
            }
            
            Spacer()
            
            VStack {
                
                HStack {
                    Button("Transcribe") {
                        speechRecognizer.reset()
                        speechRecognizer.transcribe()
                        isRecording = true
                    }.buttonStyle(.bordered)
                    Button("Stop transcribing", role: .destructive) {
                        speechRecognizer.stopTranscribing()
                        isRecording = false
                    }
                }
                
                HStack {
                    Button("Confirm") {
                        pushToStorage(log: newLog)
                        showingRecordView = false
                    }
                        .buttonStyle(.bordered)
                    
                    Button("Cancel", role: .destructive) {
                        showingRecordView = false
                    }
                }
                
            }
                
            Spacer()
        }
        .padding()

    }
}

struct RecordingView_Previews: PreviewProvider {
    static var previews: some View {
        RecordView(showingRecordView: .constant(true))
    }
}
