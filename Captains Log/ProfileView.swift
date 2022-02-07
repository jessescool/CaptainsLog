import SwiftUI

struct ProfileView: View {
    @Binding var showingProfileView: Bool
    var body: some View {
        VStack {
            Text("Profile").font(.title)
            Button("Hide profileView") {
                showingProfileView = false
            }
        }
    }
}


struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(showingProfileView: .constant(false))
    }
}
