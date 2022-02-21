import SwiftUI

struct ProfileView: View {
    @StateObject var audioRecorder = AudioRecorder()
    
    var body: some View {
        VStack {
            Button("Record") {
                audioRecorder.recorder.record()
            }
            if audioRecorder.recorder.isRecording {
                Text("recording")
            } else {
                Text("nope")
            }
            Button("Stop") {
                audioRecorder.recorder.stop()
            }
        }
        .navigationBarHidden(false)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)

    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .navigationBarHidden(false)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
