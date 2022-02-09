import Foundation
import SwiftUI

struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .foregroundColor(.white)
                .font(Font.custom("Times New Roman", size: 30))
            Spacer()
        }
        .padding()
        .background(Color.red.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct TitleView: View {
    @State var showingNewLogView: Bool = false
    
    var body: some View {
        VStack {
            
    // ----------
        
        Spacer()
        
    // ----------
        
        Button() {
            showingNewLogView = true
        } label: {
            Image(systemName: "mic.fill")
        }
            .buttonStyle(RecordButton())
            .padding()
            .sheet(isPresented: $showingNewLogView /* onDismiss: reset log sitaution */ ) {
                RecordingView()
            }
        }
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TitleView()
                .navigationBarTitleDisplayMode(.inline)
                .navigationTitle("Recording")
        }
    }
}
