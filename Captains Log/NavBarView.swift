//
//  NavBarView.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/5/22.
//
import SwiftUI

struct NavBarView: View {
    @Binding var showingProfileView: Bool
    @Binding var showingSettingsView: Bool
    
    var body: some View {
        HStack {
            NavigationLink(destination: ProfileView(showingProfileView: $showingProfileView)) {
                Image(systemName: "person")
                    .padding(.leading, 15)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text("Captain's Log").font(.title).bold()
            
            Spacer()
            
            NavigationLink(destination: SettingsView(showingSettingsView: $showingSettingsView)) {
                Image(systemName: "gear")
                    .padding(.trailing, 15)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView(showingProfileView: .constant(false), showingSettingsView: .constant(false))
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
