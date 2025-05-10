import SwiftUI

struct ImageResponse: Identifiable {
    let id = UUID()
    let image: NSImage
    let prompt: String
    var response: String
    var isTyping: Bool
}
