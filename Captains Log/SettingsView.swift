//
//  SettingsView.swift
//  Captains Log
//
//  Created by Jesse Cool on 1/4/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showSettingsView: Bool
    var body: some View {
        VStack {
            Text("Settings").font(.title)
            Button("Hide settingsView") {
                showSettingsView = false
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showSettingsView: .constant(true))
    }
}
