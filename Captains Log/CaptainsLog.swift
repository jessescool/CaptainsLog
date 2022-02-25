import SwiftUI

@main
struct CaptainsLog: App {
    
    @ObservedObject var appSettings = AppSettings.settings
    @Environment(\.colorScheme) var currentSystemTheme
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView {
                    TitleView()
                    LogbookView()
                }
                .navigationBarHidden(true)
                .tabViewStyle(.page(indexDisplayMode: .never))
                .preferredColorScheme(appSettings.forcedTheme.scheme ?? currentSystemTheme)
            }
        }
    }
}
