import Foundation
import SwiftUI

class Settings: ObservableObject {
    
    // is this the right way to do a settings object?
    
    // General
    static var defaultSort: Sort = .name
    static var hapticFeedback: Bool = true
    
    // Appearance
    static var defaultColor: Color = Color(hue: 0.576, saturation: 0.672, brightness: 0.568)
    static var theme: ColorScheme = ColorScheme.light

    // Privacy & Security
//    var authentication (not yet ready)
//    var logEncryption
    
    
}

class User: ObservableObject {
    
}
