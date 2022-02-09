import SwiftUI

struct RoundedRectangleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
                Spacer()
                configuration.label
                    .foregroundColor(.black)
                    .font(Font.custom("Times New Roman", size: 18))
                Spacer()
            
        }
        .padding()
        .background(Color.yellow.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
