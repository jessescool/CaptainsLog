import SwiftUI

@main
struct CaptainsLog: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView {
                    TitleView()
                    LogbookView(logs: logBook)
                }
                .navigationBarHidden(true)
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
