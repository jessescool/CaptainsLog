import SwiftUI

extension Color {
    static let defaultBlue = Color(hue: 0.576, saturation: 0.672, brightness: 0.568)
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
