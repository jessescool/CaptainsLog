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
    
    var body: some View {
        NavigationView {
            VStack {
                NavBarView()
                    .padding()
                Spacer()
                LogViewList(logs: LogEntry.tempData)
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
