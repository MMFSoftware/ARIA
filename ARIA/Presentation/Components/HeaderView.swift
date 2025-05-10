import SwiftUI

struct HeaderView: View {
    let title: String
    let subtitle: String
    
    var body: some View {
        VStack {
            Text(title)
                .font(.system(size: 24, weight: .bold, design: .monospaced))
            
            Text(subtitle)
                .font(.system(size: 16, design: .monospaced))
                .foregroundColor(.gray)
                .padding(.bottom, 20)
        }
    }
}
