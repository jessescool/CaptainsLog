import SwiftUI

extension Color {
    static let defaultBlue = Color(hue: 0.576, saturation: 0.672, brightness: 0.568)
    static let recordRed = Color(hue: 0, saturation: 0.9, brightness: 0.69)
}

extension Image {
    func navBarIcon(withPadding type: Edge.Set) -> some View {
        self
            .foregroundColor(.defaultBlue)
            .imageScale(.large)
            .padding(type, 25)
    }
}

enum Sort: String {
    case date = "date"
    case name = "name"
    case duration = "duration"
}

struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .foregroundColor(.white)
                .font(Font.custom("San Fransisco", size: 30))
            Spacer()
        }
        .padding()
        .background(Color.recordRed)
        .cornerRadius(8)
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
