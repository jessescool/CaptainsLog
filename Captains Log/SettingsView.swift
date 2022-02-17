import Foundation
import SwiftUI
import PopupView

struct SettingsView: View {
    
    @Environment(\.colorScheme) var systemTheme
    @State private var showingAboutPopup: Bool = false
    @State private var showingTipJar: Bool = false
    
    // temporary bindings
    @State private var hapticFeedback: Bool = true
    @State private var showingDefaultSort: Bool = false
    @State private var defaultSort: Sort = Sort.name
    @State private var customColor: Color = Color.defaultBlue
    @State private var setTheme: ColorScheme = .light
    
    var body: some View {
        VStack {
            List {
                
                Section(header: Text("General")) {
                    
                    Button {
                        showingDefaultSort = true
                    } label: {
                        HStack {
                            Label("Default Sort", systemImage: "arrow.up.arrow.down")
                            Spacer()
                            Text(defaultSort.rawValue)
                                .foregroundColor(.secondary)
                        }
                    }
                    .confirmationDialog("Default sorting method:", isPresented: $showingDefaultSort, titleVisibility: .hidden) {
    
                        Button("Name") { defaultSort = Sort.name }
                        Button("Date created ") { defaultSort = Sort.date }
                        Button("Duration") { defaultSort = Sort.duration }
                        
                    }
                    
                    HStack {
                        Label("Haptic Feedback", systemImage: "waveform")
                        Spacer()
                        Toggle("Toggle haptic feedback", isOn: $hapticFeedback)
                            .labelsHidden()
                    }
                    
                }
                
                Section(header: Text("Appearance")) {
                    HStack {
                        Label("Accent Color", systemImage: "paintpalette")
                        Spacer()
                        ColorPicker("Set an accent color", selection: $customColor)
                            .labelsHidden()
                    }
                    HStack {
                        Label("Theme", systemImage: "moon")
                        Spacer()
                        Picker("Choose a theme", selection: $setTheme) {
                            Image(systemName: "arrow.2.squarepath")
                            Image(systemName: "sun.max")
                            Image(systemName: "moon")
                        }
                        .frame(width: 150) // bad to use constant values
                        .pickerStyle(.segmented)
                    }
                }
                
                Section(header: Text("Privacy & Security")) {
                    
                    NavigationLink(destination: PasswordView()) {
                        Label("FaceID & Passcode", systemImage: "faceid")
                    }
                    
                    NavigationLink(destination: EncryptionView()) {
                        Label("Log Encryption", systemImage: "key")
                    }
                }
                
                
                
                Section {
                    Button {
                        showingAboutPopup = true
                    } label: {
                        Label("About", systemImage: "at")
                    }
                    
                    Button {
                        showingTipJar = true
                    } label: {
                        Label("Tip Jar", systemImage: "centsign.square")
                    }
                    
                    Label("Rate Captain's Log", systemImage: "heart.fill")
                }
                
                Section {
                    Label("Export Logs...", systemImage: "square.and.arrow.up.on.square")
                    NavigationLink(destination: ResetView()) {
                        Label("Reset...", systemImage: "trash")
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
                .frame(width: 300, height: 400)
                .padding()
                .background(.cyan)
            }
            
            .popup(isPresented: $showingTipJar, dragToDismiss: false, closeOnTap: false, closeOnTapOutside: true) {
                VStack {
                    Text("Tip Jar").font(.title)
                    Text("Make a donation").font(.title2)
                    Spacer()
                }
                .frame(width: 300, height: 400)
                .padding()
                .background(.cyan)
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
