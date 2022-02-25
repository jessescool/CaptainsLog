import Foundation
import SwiftUI
import PopupView

struct Row<Appendage: View>: View {
    var text: String
    var textColor: Color = .primary
    var icon: Image
    var iconColor: Color = .blue
    var appendage: Appendage
    
    var body: some View {
        HStack {
            Label {
                Text(text).foregroundColor(textColor)
            } icon: {
                // temporarily for system icons only
                icon.foregroundColor(iconColor)
            }
            
            Spacer()
            
            appendage
            
        }
    }
}

struct SettingsView: View {
    
    @State private var showingAboutPopup: Bool = false
    @State private var showingTipJar: Bool = false
    @State private var showingReset: Bool = false
    @State private var showingDefaultSort: Bool = false

    @ObservedObject var appSettings = AppSettings.settings
    
    var body: some View {
        VStack {
            List {
                
                Section(header: Text("General")) {
                    
                    Button {
                        showingDefaultSort = true
                    } label: {
                        Row(text: "Default Sort", icon: Image(systemName: "arrow.up.arrow.down"),
                            appendage: Text(appSettings.defaultSort)
                                .foregroundColor(.secondary)
                        )
                    }
                    .confirmationDialog("Choose a default sorting method...", isPresented: $showingDefaultSort, titleVisibility: .visible) {
                        
                        ForEach(Sort.allCases) { rule in
                            Button {
                                appSettings.defaultSort = rule.rawValue
                            } label: {
                                Text(rule.rawValue)
                            }
                        }
                        
                    }
                    
                    
                    
                    Row(text: "Haptic Feedback", icon: Image(systemName: "waveform"),
                        appendage: Toggle("Toggle haptic feedback", isOn: $appSettings.hapticFeedback)
                            .labelsHidden()
                    )
                    
                }
                
                Section(header: Text("Theme")) {
                    
                    Picker(selection: $appSettings.accentColor) {
                        ForEach(AppAccentColor.allCases) { color in
                            Image(systemName: "circle.fill")
                                .foregroundColor(color.inColor)
                        }
                    } label: {
                        Label("Accent Color", systemImage: "paintpalette")
                    }
                    
                    
                    Row(text: "Theme", icon: Image(systemName: "moon"),
                        appendage: Picker("Choose a theme", selection: $appSettings.forcedTheme) {
                        
                        Image(systemName: "arrow.2.squarepath").tag(Theme.none)
                        Image(systemName: "sun.max").tag(Theme.light)
                        Image(systemName: "moon").tag(Theme.dark)
                        
                        }
                            .pickerStyle(.segmented)
                            .padding(.leading) // BAD: attempting to resize splitting row
                    )
                    
                
                }
                
                Section(header: Text("Privacy & Security")) {
                    
                    Row(text: "FaceID & Passcode", icon: Image(systemName: "faceid"),
                        appendage: Toggle("Toggle Face ID & Passcode", isOn: $appSettings.authenticate).labelsHidden()
                    )
                    
                    NavigationLink(destination: EncryptionView()) {
                        Row(text: "Log Encryption", icon: Image(systemName: "key"),
                            appendage: Spacer()
                        )
                    }
                    
                }
                
                Section {
                    
                    Button {
                        showingAboutPopup = true
                    } label: {
                        Row(text: "About", icon: Image(systemName: "at"),
                            appendage: Spacer()
                        )
                    }
                    
                    Button {
                        showingTipJar = true
                    } label: {
                        Row(text: "Tip Jar", icon: Image(systemName: "centsign.square"),
                            appendage: Spacer()
                        )
                    }
                    
                    Button {
                    } label: {
                        Row(text: "Rate Captain's Log", icon: Image(systemName: "heart.fill"),
                            appendage: Spacer()
                        )
                    }
                    
                }
                
                Section {
                    
                    Button(role: .destructive) {
                        showingReset = true
                    } label: {
                        Row(text: "Reset...", icon: Image(systemName: "trash"), iconColor: .red,
                            appendage: Spacer()
                        )
                    }
                    .confirmationDialog("Reset dialogue", isPresented: $showingReset, titleVisibility: .hidden) {
                        
                        Button("Reset default accent color", role: .destructive) {
                            print("resetting default color") // Needs functionality....
                        }
                        .buttonStyle(.borderedProminent)
                        
                        Button("Delete all log entries", role: .destructive) {
                            try! realm.write {
                                let allLogs = realm.objects(LogEntry.self)
                                realm.delete(allLogs)
                            }
                        }
                        
                    }
                    
                }
                
            }
            .listStyle(.insetGrouped)
            
            // About POPUP
            .popup(isPresented: $showingAboutPopup, dragToDismiss: false, closeOnTap: false, closeOnTapOutside: true) {
                VStack {
                    Text("About").font(.title)
                    Text("Version 1.0").font(.title2)
                    Spacer()
                    Text("Captain's Log is an voice log swith supporting features like search, transcription, sorting. Based on the Captain's Log from Gene Roddenberry's Star Trek, the original idea of the app was to create a simple voice recorder to help remember the days that pass by.")
                }
                .frame(width: 320, height: 400)
                .padding()
                .background(.gray)
                .cornerRadius(10)
            }
            
            .popup(isPresented: $showingTipJar, dragToDismiss: false, closeOnTap: false, closeOnTapOutside: true) {
                VStack {
                    Text("Tip Jar").font(.title)
                    Text("Make a donation").font(.title2)
                    Spacer()
                }
                .frame(width: 320, height: 400)
                .padding()
                .background(.gray)
                .cornerRadius(10)
            }
            
        }

        .navigationBarHidden(false)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            SettingsView()
                .navigationBarHidden(false)
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
        }
    }
}
