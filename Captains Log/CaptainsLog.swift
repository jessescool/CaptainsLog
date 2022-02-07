//
//  Captains_LogApp.swift
//  Captains Log
//
//  Created by Jesse Cool on 10/21/21.
//

import SwiftUI

@main
struct CaptainsLog: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TitleView()
                .navigationBarHidden(true)
            }
        }
    }
}
