//
//  NavBarView.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/5/22.
//

import SwiftUI

struct NavBarView: View {
    var body: some View {
        HStack {
            NavigationLink(destination: ProfileView()) {
                Text("\(Image(systemName: "person"))")
                    .padding(.leading, 30.0)
                    .foregroundColor(.blue)
            }
            
            Spacer()
            
            Text("Captain's Log").font(.title).bold()
            
            Spacer()
            
            NavigationLink(destination: BlackHoleView()) {
                Text("\(Image(systemName: "gear"))")
                    .padding(.trailing, 30.0)
                    .foregroundColor(.blue)
            }
        }
    }
}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
            .previewLayout(.fixed(width: 400, height: 60))
    }
}
