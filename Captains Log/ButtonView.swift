import SwiftUI


struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            Spacer()
            configuration.label
                .foregroundColor(.white)
                .font(Font.custom("Times New Roman", size: 30))
            Spacer()
        }
        .padding()
        .background(Color.red.cornerRadius(8))
        .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}

struct ButtonView: View {
    @Binding var showingNewLogView: Bool
    
    var body: some View {
        Button() {
            showingNewLogView = true
        } label: {
            Image(systemName: "mic.fill")
        }
            .buttonStyle(RecordButton())
            .padding()
    }
}


struct ButtonView_Previews: PreviewProvider {
    static var previews: some View {
        ButtonView(showingNewLogView: .constant(false))
            .previewLayout(.fixed(width: 400, height: 100))
    }
}
