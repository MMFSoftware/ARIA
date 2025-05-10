import SwiftUI

struct ImageThumbnail: View {
    let image: NSImage
    let onRemove: () -> Void
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Image(nsImage: image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .cornerRadius(8)
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.gray.opacity(0.3), lineWidth: 1)
                )
                .clipped()
            
            Button(action: onRemove) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.white)
                    .background(Circle().fill(Color.black.opacity(0.6)))
            }
            .buttonStyle(PlainButtonStyle())
            .padding(4)
        }
    }
}

#Preview {
    ZStack {
        Color(.darkGray)
        ImageThumbnail(
            image: NSImage(named: NSImage.userAccountsName)!,
            onRemove: {}
        )
    }
    .frame(width: 100, height: 100)
}
