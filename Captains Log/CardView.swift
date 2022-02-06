import SwiftUI

struct CardView: View {
    let log: LogEntry
    var body: some View {
        VStack(alignment: .leading) {
            Text(log.name)
                .font(.headline)
            Spacer()
            HStack {
                Label("\(log.date)", systemImage: "person")
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Attendees"))
                    .accessibilityValue(Text("moo"))
                Spacer()
                Label("\(log.duration)", systemImage: "clock")
                    .padding(.trailing, 20)
                    .accessibilityElement(children: .ignore)
                    .accessibilityLabel(Text("Log length"))
                    .accessibilityValue(Text("\(log.duration)"))
            }
            .font(.caption)
        }
        .padding()
        .foregroundColor(.blue)
    }
}

struct CardView_Previews: PreviewProvider {
    static var log = LogEntry.tempData[0]
    static var previews: some View {
        CardView(log: log)
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
