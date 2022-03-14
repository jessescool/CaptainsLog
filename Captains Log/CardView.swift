import SwiftUI

struct CardView: View {
    let log: LogEntry
    
    var body: some View {
        
        VStack(alignment: .leading) {
            Text(log.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(log.date.formatted(date: .abbreviated, time: .omitted))", systemImage: "calendar")
                Spacer()
                Label("\(Int(log.duration.rounded()))s", systemImage: "hourglass.tophalf.filled")
            }
        }
        .foregroundColor(.accentColor)
        .padding()
    }
}

struct CardView_Previews: PreviewProvider {
    static var log = LogEntry(name: "Foodstuffs")
    static var previews: some View {
        CardView(log: log)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
