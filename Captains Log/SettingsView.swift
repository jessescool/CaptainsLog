import Foundation
import SwiftUI

struct SettingsView: View {
    
    @Environment(\.colorScheme) var systemTheme
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
                    NavigationLink(destination: AboutView()) {
                        Label("About", systemImage: "at")
                    }
                    Label("Tip Jar", systemImage: "centsign.square")
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
