//
//  NavBarView.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/5/22.
//

import SwiftUI

struct NavBarView: View {
    @Binding var showProfileView: Bool
    @Binding var showSettingsView: Bool
    
    var body: some View {
        HStack {
            NavigationLink(destination: ProfileView(showProfileView: $showProfileView)) {
                Text("\(Image(systemName: "person"))")
                    .padding(.leading, 30.0)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text("Captain's Log").font(.title).bold()
            
            Spacer()
            
            NavigationLink(destination: SettingsView(showSettingsView: $showSettingsView)) {
                Text("\(Image(systemName: "gear"))")
                    .padding(.trailing, 30.0)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(showProfileView: .constant(false), showSettingsView: .constant(false))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
