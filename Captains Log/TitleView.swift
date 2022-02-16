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
        .background(Color.defaultBlue.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct TitleView: View {
    private var date = Date.now.formatted(date: .complete, time: .omitted)
    private var time = Date.now.formatted(date: .omitted, time: .shortened)
    @State var showingRecordView: Bool = false
    
    var body: some View {
        VStack {
            
            HStack {
                NavigationLink(destination: ProfileView()) {
                    Image(systemName: "person")
                        .navBarIcon(withPadding: .leading)
                }
                
                Spacer()
                Text("Recording").font(.title).bold()
                Spacer()
                
                NavigationLink(destination: SettingsView()) {
                    Image(systemName: "gear")
                        .navBarIcon(withPadding: .trailing)
                }
            }
            .padding()
            
            Spacer()

    // ----------
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: "calendar")
                    Text("\(date)")
                        .font(.title2)
                        .bold()
                }
                HStack {
                    Image(systemName: "clock")
                    Text("\(time)")
                        .font(.title2)
                        .bold()
                }
            }
                
            Spacer()
        
    // ----------
        
            Button() {
                showingRecordView = true
            } label: {
                Image(systemName: "mic.fill")
            }
                .buttonStyle(RecordButton())
                .padding()
                .sheet(isPresented: $showingRecordView /* onDismiss: reset log sitaution */ ) {
                    RecordView(showingRecordView: $showingRecordView)
                }
        }
    }
}


struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TitleView()
                .navigationBarHidden(true)
        }
    }
}
