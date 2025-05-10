import SwiftUI

struct ResponseCard: View {
    let response: ImageResponse

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ZStack {
                Color.black
                Image(nsImage: response.image)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity)
                    .frame(height: 160)
            }
            .frame(height: 160)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray.opacity(0.3), lineWidth: 1)
            )
            .clipped()

            HStack {
                Spacer()

                Text(response.prompt)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .monospaced()
                    .lineLimit(1)

                Image(systemName: "person.crop.circle")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)
                    .foregroundColor(.gray)
            }

            Divider()
                .background(Color.gray.opacity(0.3))
            HStack(alignment: .top) {
                Image(systemName: "cpu")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 20)

                if response.isTyping {
                    TypingIndicator()
                        .padding(.vertical, 10)
                } else {
                    Text(response.response)
                        .font(.caption)
                        .foregroundColor(.white)
                        .monospaced()
                }

                Spacer()
            }

            Spacer(minLength: 0)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color(.cardBg))
        .cornerRadius(12)
    }
}

#Preview {
    ZStack {
        Color.black.edgesIgnoringSafeArea(.all)
        ResponseCard(
            response: ImageResponse(
                image: NSImage(named: NSImage.userAccountsName)!,
                prompt: "Tell me about this image",
                response: "This image has a vibrant color palette with strong contrast between warm and cool tones.",
                isTyping: false
            )
        )
        .frame(width: 300)
        .padding()
    }
}
