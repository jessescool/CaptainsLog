//
//  ContentView.swift
//  Captains Log
//
//  Created by Jesse Cool on 10/21/21.
//
import Foundation
import SwiftUI

struct TitleView: View {
    @State var showSettingsView: Bool = false
    @State var showProfileView: Bool = false
    
    var body: some View {
        NavigationView {
            VStack {
                NavBarView(showProfileView: $showProfileView, showSettingsView: $showSettingsView)
                    .padding(.bottom)
                Spacer()
                LogViewList(logs: logBook)
                Spacer()
                ButtonView()
            }
            .navigationBarHidden(true)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
