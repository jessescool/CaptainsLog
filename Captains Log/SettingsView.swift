//
//  SettingsView.swift
//  Captains Log
//
//  Created by Jesse Cool on 1/4/22.
//

import SwiftUI

struct SettingsView: View {
    @State private var showGreeting: Bool = false
    @Binding var showSettingsView: Bool
    var body: some View {
        VStack {
            Text("Settings").font(.title)
            Toggle("Hello", isOn: $showGreeting)
            Button("Hide settingsView") {
                showSettingsView = false
            }
        }
    }
}

//struct SettingsView_Previews: PreviewProvider {
//    @Binding var showSettingsView: Bool
//    static var previews: some View {
//        SettingsView()
//    }
//}
