import SwiftUI

struct TagButton: View {
    let label: String
    var icon: String? = nil
    var action: (() -> Void)? = nil
    var isDisabled: Bool = false

    var body: some View {
        Button(action: {
            if let action = action {
                action()
            }
        }) {
            HStack(spacing: 6) {
                if let icon = icon {
                    Image(systemName: icon)
                        .font(.caption)
                        .foregroundColor(isDisabled ? .gray : .white)
                }

                Text(label)
                    .font(.caption)
                    .monospaced()
                    .foregroundColor(isDisabled ? .gray : .white)
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 8)
            .background(Color(.cardBg))
            .cornerRadius(16)
            .opacity(isDisabled ? 0.6 : 1.0)
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(isDisabled)
    }
}

#Preview {
    VStack {
        TagButton(label: "Test")

        TagButton(label: "Remove", icon: "eraser.fill")
    }
}
