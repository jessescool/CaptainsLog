import SwiftUI

struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.red)
            .font(.system(size: 60, weight: .ultraLight))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
