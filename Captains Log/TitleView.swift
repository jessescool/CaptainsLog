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
    @State var showingSettingsView: Bool = false
    @State var showingProfileView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                
            // ----------
                
                HStack {
                    NavigationLink(destination: ProfileView(showingProfileView: $showingProfileView)) {
                        Image(systemName: "person")
                            .padding(.leading, 15)
                            .foregroundColor(.blue)
                    }
                    
                    Spacer()
                    Text("Recording").font(.title).bold()
                    Spacer()
                    
                    NavigationLink(destination: SettingsView(showingSettingsView: $showingSettingsView)) {
                        Image(systemName: "gear")
                            .padding(.trailing, 15)
                            .foregroundColor(.blue)
                    }
                }
                .padding()
                
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
            .navigationBarHidden(true)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
