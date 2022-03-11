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

struct SummaryInfo: View {
    private var date = Date.now.formatted(date: .complete, time: .omitted)
    private var time = Date.now.formatted(date: .omitted, time: .shortened)
    @StateObject var locationManager = LocationManager()
    
    var body: some View {
        VStack(alignment: .center) {
            
            HStack {
                Image(systemName: "mappin")
                Text(locationManager.lastPlacemark?.subLocality ?? "Unknown")
                    .bold()
            }
            .padding()
            
            HStack {
                Image(systemName: "calendar")
                Text("\(date)")
                    .bold()
            }
            .padding()
            
            HStack {
                Image(systemName: "clock")
                Text("\(time)")
                    .bold()
            }
            .padding()
        }
        .font(.title2)
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
            options: recordViewPosition != .bottom ? middleSheetOptions : bottomSheetOptions,
            headerContent: {
                if recordViewPosition == .bottom { Record(recordViewPosition: $recordViewPosition) }
            })

        { // content:
            RecordView(recordView: $recordViewPosition)
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
