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
                Label("\(log.duration, specifier: "%.2f")", systemImage: "clock")
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(Color(hue: 0.576, saturation: 0.672, brightness: 0.568))
    }
}

struct CardView_Previews: PreviewProvider {
    static var log = LogEntry.tempData[0]
    static var previews: some View {
        CardView(log: log)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
