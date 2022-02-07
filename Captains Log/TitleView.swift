//
//  ContentView.swift
//  Captains Log
//
//  Created by Jesse Cool on 10/21/21.
//
import Foundation
import SwiftUI

struct TitleView: View {
    @State var showingNewLogView: Bool = false
    
    @State var showingSettingsView: Bool = false
    @State var showingProfileView: Bool = false
    
    var body: some View {
        VStack {
            NavBarView(showingProfileView: $showingProfileView, showingSettingsView: $showingSettingsView)
                .padding()
            Spacer()
            LogViewList(logs: LogEntry.tempData)
            Spacer()
            ButtonView(showingNewLogView: $showingNewLogView)
        }
    }
}

struct TitleView_Previews: PreviewProvider {
    static var previews: some View {
        TitleView()
    }
}
