import SwiftUI
import CoreLocation

struct ProfileView: View {
    
    var body: some View {
        Text("Hello")
    }
    
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ProfileView()
                .navigationBarHidden(false)
                .navigationTitle("Profile")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
