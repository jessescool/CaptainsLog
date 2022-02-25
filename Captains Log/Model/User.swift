import Foundation
import SwiftUI

enum Theme: Int { // int?
    case light
    case dark
    case none
    
    var scheme: ColorScheme? {
        switch self {
        case .light: return .light
        case .dark: return .dark
        case .none: return nil
        }
    }
}

enum AppAccentColor: Int, CaseIterable, Identifiable { // int?
    case red
    case blue
    case yellow
    var id: Self { self }
    
    var inColor: Color { // bad name...
        switch self {
        case .red: return Color(hex: "C0392B")
        case .blue: return Color(hex: "2980B9")
        case .yellow: return Color(hex: "F1C40F")
        }
    }
}

enum Sort: String, CaseIterable, Identifiable {
    case date = "date"
    case name = "name"
    case duration = "duration"
    var id: Self { self }
}

class AppSettings: ObservableObject {
    static let settings = AppSettings()
    
    @AppStorage("hapticFeedback") var hapticFeedback: Bool = true
    @AppStorage("defaultSort") var defaultSort: String = Sort.name.rawValue
    @AppStorage("authenticate") var authenticate: Bool = false
    @AppStorage("forcedTheme") var forcedTheme: Theme = .none
    
    @AppStorage("accentColor") var accentColor: AppAccentColor = .red
    
}

class AppUser: ObservableObject {
    static let user = AppUser()
}
