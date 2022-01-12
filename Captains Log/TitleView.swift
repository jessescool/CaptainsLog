//
//  ContentView.swift
//  Captains Log
//
//  Created by Jesse Cool on 10/21/21.
//
import Foundation
import SwiftUI

@available(iOS 15.0, *)
struct TitleView: View {
    var body: some View {
        VStack {
            
            HStack {

                NavigationLink(destination: ProfileView()) {
                    Text("\(Image(systemName: "person"))")
                        .padding(.leading, 30.0)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Text("Captain's Log").bold()
                
                Spacer()
                
                NavigationLink(destination: SettingsView()) {
                    Text("\(Image(systemName: "gear"))")
                        .padding(.trailing, 30.0)
                        .foregroundColor(.blue)
                }
                
            }
            Spacer()
            ButtonView()
        }
    }
}

@available(iOS 15.0, *)
struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
