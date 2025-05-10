import SwiftUI

struct TitleView: View {
    var body: some View {
        VStack(spacing: 4) {
            Text("A.R.I.A.")
                .font(.system(size: 32, weight: .bold, design: .monospaced))
                .transition(.scale.combined(with: .opacity))
                .animation(.easeOut(duration: 0.6), value: true)
            
            Text("AI Review for Image Analysis")
                .font(.system(size: 14, weight: .regular, design: .monospaced))
                .foregroundColor(.gray)
                .transition(.opacity)
                .animation(.easeOut(duration: 0.4).delay(0.3), value: true)
        }
    }
}

#Preview {
    TitleView()
}
