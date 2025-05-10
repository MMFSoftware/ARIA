import SwiftUI

struct LogoView: View {
    var body: some View {
        Image(.logo)
            .resizable()
            .scaledToFit()
            .frame(height: 200)
            .cornerRadius(12)
    }
}

#Preview {
    LogoView()
}
