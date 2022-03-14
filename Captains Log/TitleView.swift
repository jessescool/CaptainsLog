import Foundation
import SwiftUI
import CoreLocation
import BottomSheet

struct TitleHeader: View {
    var body: some View {
        HStack {
            NavigationLink(destination: ProfileView()) {
                Image(systemName: "person")
                    .navBarIcon(withPadding: .leading)
            }
            
            Spacer()
            Text("Record").font(.title).bold()
            Spacer()
            
            NavigationLink(destination: SettingsView()) {
                Image(systemName: "gear")
                    .navBarIcon(withPadding: .trailing)
            }
        }
    }
}



struct TitleView: View {
    @State var recordViewPosition: RecordSheetPosition = .bottom //1

    var body: some View {
        VStack {

            TitleHeader()
                .padding()

            Spacer()

            SummaryInfo()
                .padding()

            Spacer()
            Spacer()

    // ----------

        }
        .bottomSheet(
            bottomSheetPosition: $recordViewPosition,
            options: recordViewPosition != .bottom ? middleSheetOptions : bottomSheetOptions
        ){ // content:
            if recordViewPosition == .bottom {
                withAnimation {
                    VStack {
                        Spacer()
                        Record(recordViewPosition: $recordViewPosition)
                    }
                    .transition(.opacity)
                }
            } else {
                withAnimation {
                    VStack {
                        RecordView(recordView: $recordViewPosition)
                    }
                    .transition(.opacity)
                }
            }
        }

    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            TitleView()
                .navigationBarHidden(true)
        }
    }
}
