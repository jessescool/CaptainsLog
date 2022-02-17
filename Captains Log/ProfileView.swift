import SwiftUI

struct ProfileView: View {
    var body: some View {
        VStack {

        }
        .navigationBarHidden(false)
        .navigationTitle("Profile")
        .navigationBarTitleDisplayMode(.inline)

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
