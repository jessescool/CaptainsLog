//
//  SettingsView.swift
//  Captains Log
//
//  Created by Jesse Cool on 1/4/22.
//

import SwiftUI

struct SettingsView: View {
    @Binding var showingSettingsView: Bool
    var body: some View {
        VStack {
            Text("Settings").font(.title)
            Button("Hide settingsView") {
                showingSettingsView = false
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showingSettingsView: .constant(true))
    }
}
