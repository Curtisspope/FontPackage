import SwiftUI
import CoreText

public enum GaramondFont {
        /// The name of the font as registered in the system
    public static let name = "AppleGaramond"
    
        /// Font sizes that can be used with the Garamond font
    public struct Size {
        public static let headline: CGFloat = 92
    }
    
        /// Ensures the font is registered only once
    nonisolated(unsafe) private static var hasRegistered = false
    
        /// Register the font with the system
    @discardableResult
    public static func register() -> Bool {
        guard !hasRegistered else { return true }
        hasRegistered = true
        
        let bundle = Bundle.module
        guard let fontURL = bundle.url(forResource: name, withExtension: "ttf") else {
            return false
        }
        
        var error: Unmanaged<CFError>?
        let success = CTFontManagerRegisterFontsForURL(fontURL as CFURL, .process, &error)
        
        if !success, let error = error?.takeUnretainedValue() {

        }
        
        return success
    }
}

    // MARK: - Font Extension

public extension Font {
        /// Creates a Garamond font with the specified size
    static func garamond(size: CGFloat) -> Font {
        _ = GaramondFont.register()
        return .custom(GaramondFont.name, size: size)
    }
    
    
    static var garamondHeadline: Font {
        .garamond(size:  GaramondFont.Size.headline)
    }
}
