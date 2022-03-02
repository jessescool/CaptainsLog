import SwiftUI
import CoreLocation
import RealmSwift

struct ProfileView: View {
    @ObservedRealmObject var profile: User = User.defaultUser
    @State private var tagName: String = ""
    @State private var isChangingUsername: Bool = false
    
    var body: some View {
        VStack {
            VStack(alignment: .leading) {
                
                if isChangingUsername {
                    
                    HStack(alignment: .center) {
                        Button {
                            isChangingUsername = false
                        } label: {
                            Text("Confirm")
                        }
                        .buttonStyle(.bordered)
                        TextField("Enter a new username...", text: $profile.username)
                            .labelsHidden()
                            .font(.title2)
                    }
                    
                } else {
                    
                    HStack(alignment: .center){
                        
                        Button {
                            isChangingUsername = true
                        } label: {
                            Image(systemName: "pencil")
                                .imageScale(.large)
                        }
                        
                        Text(profile.username)
                            .font(.title2)
                    }
                    
                }
                
                
            }
            .padding()
            
            HStack {
                VStack {
                    Text("Total duration:")
                    Text(String(profile.statistics.minutesRecorded))
                }
                VStack {
                    Text("Most common words:")
                    Text(profile.statistics.mostUsedWords.joined(separator: ", "))
                }
            }
            
            VStack {
                ScrollView(.horizontal) {
                    HStack {
                        ForEach(profile.tags, id: \.self) { tag in
                            Text(tag.name)
                                .font(.title3)
                        }
                    }
                }
            }
            .padding()
            
            Spacer()

            TextField("Add a tag", text: $tagName)
            Button("Add tag") {
                profile.addTag(Tag(name: tagName))
                self.tagName = ""
            }
        }
        .padding()
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
