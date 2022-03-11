import Foundation
import SwiftUI
import BottomSheet

var allSheetOptions: [BottomSheet.Options] = []

var bottomSheetOptions: [BottomSheet.Options] = [.noDragIndicator, .cornerRadius(0)] + allSheetOptions
var middleSheetOptions: [BottomSheet.Options] = [.allowContentDrag, .swipeToDismiss, .cornerRadius(25)] + allSheetOptions
var topSheetOptions: [BottomSheet.Options] = [.allowContentDrag, .swipeToDismiss, .cornerRadius(25)] + allSheetOptions


public enum RecordSheetPosition: CGFloat, CaseIterable {
    case top = 0.975, middle = 0.4, bottom = 0.15, hidden = 0
}

struct Record: View {
    @Binding var recordViewPosition: RecordSheetPosition
    
    var body: some View {
        HStack {
            Spacer()
            Button() {
                withAnimation(.easeIn(duration: 0.1)) {
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

