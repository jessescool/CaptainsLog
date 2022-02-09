import SwiftUI

@main
struct CaptainsLog: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                TabView {
                    TitleView()
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Recording")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarLeading) {
                                NavigationLink(destination: ProfileView()) {
                                    Image(systemName: "person")
                                        .padding(.leading, 15)
                                }
                            }
                            ToolbarItem(placement: .navigationBarTrailing) {
                                NavigationLink(destination: SettingsView()) {
                                    Image(systemName: "gear")
                                        .padding(.leading, 15)
                                }
                            }
                        }
                    LogbookView(logs: LogEntry.tempData)
                        .navigationBarTitleDisplayMode(.inline)
                        .navigationTitle("Logbook")
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
    }
}
