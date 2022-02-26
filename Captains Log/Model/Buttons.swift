import SwiftUI

//struct RecordButton: ButtonStyle {
//    func makeBody(configuration: Configuration) -> some View {
//        HStack {
//            Spacer()
//            configuration.label
//                .foregroundColor(.white)
//                .font(.system(size: 30, weight: .light))
//                .padding()
//            Spacer()
//        }
//        .background(Color.recordRed)
//        .cornerRadius(25)
//        .scaleEffect(configuration.isPressed ? 0.95 : 1)
//    }
//}

struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.accentColor)
            .font(.system(size: 140, weight: .ultraLight))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
