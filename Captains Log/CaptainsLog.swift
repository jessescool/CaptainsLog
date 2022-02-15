import SwiftUI

@main
struct CaptainsLog: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView {
                    TitleView()
                    LogbookView()
                }
                .navigationBarHidden(true)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
