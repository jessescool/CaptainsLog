import Foundation
import SwiftUI
import PopupView

struct Row<Actor: View>: View {
    var text: String
    var textColor: Color = .primary
    var icon: Image
    var iconColor: Color = .blue
    var actor: Actor
    
    var body: some View {
        HStack {
            Label {
                Text(text).foregroundColor(textColor)
            } icon: {
                // temporarily for system icons only
                icon.foregroundColor(iconColor)
            }
            
            Spacer()
            
            actor
            
        }
    }
}

struct SettingsView: View {
    
    @State private var showingAboutPopup: Bool = false
    @State private var showingTipJar: Bool = false
    @State private var showingReset: Bool = false
    @State private var showingDefaultSort: Bool = false

    // temporary bindings
    @AppStorage("hapticFeedback") private var hapticFeedback: Bool = true
    @AppStorage("defaultSort") private var defaultSort: Sort = Sort.name
    @AppStorage("accentColorHex") private var accentColorHex: String = "BC3333"
    @State private var accentColor: Color = Color.red // needs AppStorage
    
    @Environment(\.colorScheme) var currentSystemTheme
    @AppStorage("syncWithSystemTheme") private var syncWithSystemTheme: Bool = true
    @AppStorage("forcedThemeString") private var forcedThemeString: String = "light"
    @State private var forcedTheme: ColorScheme = .light // needs AppStorage
    
    var body: some View {
        VStack {
            List {
                
                Section(header: Text("General")) {
                    
                    
                    
                    Button {
                        showingDefaultSort = true
                    } label: {
                        Row(text: "Default Sort", icon: Image(systemName: "arrow.up.arrow.down"),
                            actor: Text(defaultSort.rawValue)
                                .foregroundColor(.secondary)
                        )
                    }
                    .confirmationDialog("Default sorting method:", isPresented: $showingDefaultSort, titleVisibility: .hidden) {
                        Button(Sort.name.rawValue) { defaultSort = Sort.name }
                        Button(Sort.date.rawValue) { defaultSort = Sort.date }
                        Button(Sort.duration.rawValue) { defaultSort = Sort.duration }
                    }
                    
                    
                    Row(text: "Haptic Feedback", icon: Image(systemName: "waveform"),
                        actor: Toggle("Toggle haptic feedback", isOn: $hapticFeedback)
                            .labelsHidden()
                    )
                    
                }
                
                Section(header: Text("Theme")) {
                    
                    Row(text: "Accent Color", icon: Image(systemName: "paintpalette"),
                        actor: ColorPicker("Set an accent color", selection: $accentColor).labelsHidden()
                    )
                    
                    Row(text: "Use System Theme", icon: Image(systemName: "moon"),
                        actor: Toggle("Use System Mode", isOn: $syncWithSystemTheme).labelsHidden()
                    )
                    
                    if !syncWithSystemTheme {
                        Picker("Choose a theme", selection: $forcedTheme) {
                            Image(systemName: "sun.max").tag(ColorScheme.light)
                            Image(systemName: "moon").tag(ColorScheme.dark)
                        }
                        .pickerStyle(.segmented)
                        .padding(.horizontal)
                    }
                
                }
                
                Section(header: Text("Privacy & Security")) {
                    
                    NavigationLink(destination: PasswordView()) {
                        Row(text: "FaceID & Passcode", icon: Image(systemName: "faceid"),
                            actor: Spacer()
                        )
                    }
                    
                    NavigationLink(destination: EncryptionView()) {
                        Row(text: "Log Encryption", icon: Image(systemName: "key"),
                            actor: Spacer()
                        )
                    }
                    
                }
                
                
                
                Section {
                    
                    Button {
                        showingAboutPopup = true
                    } label: {
                        Row(text: "About", icon: Image(systemName: "at"),
                            actor: Spacer()
                        )
                    }
                    
                    Button {
                        showingTipJar = true
                    } label: {
                        Row(text: "Tip Jar", icon: Image(systemName: "centsign.square"),
                            actor: Spacer()
                        )
                    }
                    
                    Button {
                    } label: {
                        Row(text: "Rate Captain's Log", icon: Image(systemName: "heart.fill"),
                            actor: Spacer()
                        )
                    }
                    
                }
                
                Section {
                    
                    Button(role: .destructive) {
                        showingReset = true
                    } label: {
                        Row(text: "Reset...", icon: Image(systemName: "trash"), iconColor: .red,
                            actor: Spacer()
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
