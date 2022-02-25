import Foundation
import SwiftUI
import CoreLocation

struct TitleView: View {
    private var date = Date.now.formatted(date: .complete, time: .omitted)
    private var time = Date.now.formatted(date: .omitted, time: .shortened)

    @State var showingRecordView: Bool = false
    
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
            VStack(alignment: .leading) {
                
                HStack {
                    Image(systemName: "mappin")
                        .padding(.trailing)
                    Text("Oakland") // to be changed
                        .font(.title2)
                        .bold()
                }
                HStack {
                    Image(systemName: "calendar")
                        .padding(.trailing)
                    Text("\(date)")
                        .font(.title2)
                        .bold()
                }
                HStack {
                    Image(systemName: "clock")
                        .padding(.trailing)
                    Text("\(time)")
                        .font(.title2)
                        .bold()
                }
            }
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
