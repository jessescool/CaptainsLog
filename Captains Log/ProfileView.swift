import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        Text("hello")
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
