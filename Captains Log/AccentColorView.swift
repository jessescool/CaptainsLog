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
        List(AppAccentColor.allCases, id: \.self) { color in
            Button {
                appSettings.accentColor = color
            } label: {
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
