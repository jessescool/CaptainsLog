import SwiftUI

struct ProfileView: View {
    @Binding var showProfileView: Bool
    var body: some View {
        VStack {
            Text("Profile").font(.title)
            Button("Hide profileView") {
                showProfileView = false
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showProfileView: .constant(false))
    }
}
