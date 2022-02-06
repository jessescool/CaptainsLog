import SwiftUI
import RealmSwift

struct NewLogView: View {
    @State private var name: String = ""
    @State private var date: String = ""
    @State private var transcription: String = ""
    @State private var location: Double = 0.0
    @State private var duration: Double = 0.0

    
    // temporary data for sample log initiation
    private var randomLocation: Double {
        Double.random(in: 1...10)
    }
    
    private var randomDuration: Double {
        Double.random(in: 10...20)
    }

    var body: some View {
        VStack {
            TextField("Name", text: $name)
            TextField("Date", text: $date)
            TextField("Transcription", text: $transcription)
            Text("Random location: \(randomLocation)")
            Text("Random duration: \(randomDuration)")
        }
        .padding()
    }
}

struct NewLogView_Previews: PreviewProvider {
    static var previews: some View {
        NewLogView()
    }
}
