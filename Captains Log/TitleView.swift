import Foundation
import SwiftUI
import CoreLocation

struct TitleView: View {
    @State var showingRecordView: Bool = false
    private var date = Date.now.formatted(date: .complete, time: .omitted)
    private var time = Date.now.formatted(date: .omitted, time: .shortened)
    
    @StateObject var locationManager = LocationManager()

    var body: some View {
        VStack {
            
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
            .padding()
            
            Spacer()

    // ----------
            VStack(alignment: .center) {
                
                HStack {
                    Image(systemName: "mappin")
                    Text(locationManager.associatedPlacemark?.subLocality ?? "Unknown")
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
            .padding()
                
            Spacer()
        
    // ----------
        
            Button() {
                showingRecordView = true
            } label: {
                Image(systemName: "record.circle")
            }
            .buttonStyle(RecordButton())
            .padding()
            .sheet(isPresented: $showingRecordView /* onDismiss: reset log sitaution */ ) {
                RecordView(showingRecordView: $showingRecordView)
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
