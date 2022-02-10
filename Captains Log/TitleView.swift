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
    private var date = Date.now.formatted(date: .complete, time: .omitted)
    private var time = Date.now.formatted(date: .omitted, time: .shortened)
    @State var showingRecordView: Bool = false
    
    var body: some View {
        VStack {
            
            Text("Recording").font(.title).bold()
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
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        NavigationLink(destination: ProfileView()) {
                            Image(systemName: "person")
                                .padding(.leading, 15)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: SettingsView()) {
                            Image(systemName: "gear")
                                .padding(.trailing, 15)
                        }
                    }
                }
        }
    }
}
