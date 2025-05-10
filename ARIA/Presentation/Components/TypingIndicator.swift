import SwiftUI

struct TypingIndicator: View {
    @State private var showFirstDot = false
    @State private var showSecondDot = false
    @State private var showThirdDot = false
    
    var body: some View {
        HStack(spacing: 4) {
            Circle()
                .fill(Color.accentColor)
                .frame(width: 6, height: 6)
                .opacity(showFirstDot ? 1 : 0.3)
            
            Circle()
                .fill(Color.accentColor)
                .frame(width: 6, height: 6)
                .opacity(showSecondDot ? 1 : 0.3)
            
            Circle()
                .fill(Color.accentColor)
                .frame(width: 6, height: 6)
                .opacity(showThirdDot ? 1 : 0.3)
        }
        .onAppear {
            animate()
        }
    }
    
    private func animate() {
        withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
            showFirstDot = true
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                showSecondDot = true
            }
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
            withAnimation(Animation.easeInOut(duration: 0.4).repeatForever(autoreverses: true)) {
                showThirdDot = true
            }
        }
    }
}

#Preview {
    ZStack {
        Color.black
        TypingIndicator()
    }
    .frame(width: 100, height: 50)
}
