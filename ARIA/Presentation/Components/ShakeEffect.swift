import SwiftUI

struct ShakeEffect: AnimatableModifier {
    var shakes: CGFloat = 0

    var animatableData: CGFloat {
        get { shakes }
        set { shakes = newValue }
    }

    func body(content: Content) -> some View {
        content
            .offset(x: sin(shakes * .pi * 2) * 5)
    }
}

extension View {
    func shake(trigger: Bool) -> some View {
        modifier(Shake(trigger: trigger))
    }
}

struct Shake: ViewModifier {
    @State private var shakeCount: CGFloat = 0
    var trigger: Bool

    func body(content: Content) -> some View {
        content
            .modifier(ShakeEffect(shakes: shakeCount))
            .onChange(of: trigger) { _, newValue in
                guard newValue else { return }
                withAnimation(.linear(duration: 0.5)) {
                    shakeCount = 3
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    shakeCount = 0
                }
            }
    }
}
