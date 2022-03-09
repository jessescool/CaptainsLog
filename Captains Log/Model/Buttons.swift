import SwiftUI

struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
            .font(.system(size: 100, weight: .ultraLight))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
