import SwiftUI

struct LoadingIndicator: View {
    var body: some View {
        ProgressView("Initializing...")
            .progressViewStyle(CircularProgressViewStyle())
            .font(.system(.body, design: .monospaced))
            .transition(.opacity)
    }
}
