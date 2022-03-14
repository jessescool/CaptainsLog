import Foundation
import SwiftUI
import BottomSheet

var allSheetOptions: [BottomSheet.Options] = [.noBottomPosition]

var bottomSheetOptions: [BottomSheet.Options] = [.noDragIndicator, .cornerRadius(0)] + allSheetOptions
var middleSheetOptions: [BottomSheet.Options] = [.allowContentDrag, .swipeToDismiss, .cornerRadius(25)] + allSheetOptions
var topSheetOptions: [BottomSheet.Options] = [.allowContentDrag, .swipeToDismiss, .cornerRadius(25)] + allSheetOptions


public enum RecordSheetPosition: CGFloat, CaseIterable {
    case top = 0.975, middle = 0.4, bottom = 0.14, hidden = 0
}

struct Record: View {
    @Binding var recordViewPosition: RecordSheetPosition
    
    var body: some View {
        HStack {
            Spacer()
            Button() {
                withAnimation(.easeOut) {
                    recordViewPosition = .middle
                }
            } label: {
                Image(systemName: "record.circle")
            }
            .buttonStyle(RecordButton())
            Spacer()
        }
    }
}

struct RecordButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .foregroundColor(.red)
            .font(.system(size: 70, weight: .ultraLight))
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
    }
}
