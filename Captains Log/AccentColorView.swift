//
//  AccentColorView.swift
//  Captains Log
//
//  Created by Jesse Cool on 2/24/22.
//

import SwiftUI

struct AccentColorView: View {
    @ObservedObject var appSettings = AppSettings.settings
    
    var body: some View {
        Picker("Color", selection: $appSettings.accentColor) {
            List(AppAccentColor.allCases) { color in
                Image(systemName: "circle.fill")
                    .foregroundColor(color.inColor)
            }
        }
        .navigationTitle("Accent Color")
    }
}

struct AccentColorView_Previews: PreviewProvider {
    static var previews: some View {
        AccentColorView()
    }
}
