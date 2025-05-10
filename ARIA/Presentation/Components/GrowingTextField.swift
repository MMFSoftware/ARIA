import SwiftUI
import AppKit

struct GrowingTextField: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .foregroundColor(.gray)
                    .monospaced()
                    .padding(.leading, 2)
                    .padding(.top, 1)
            }

            NSTextViewWrapper(text: $text)
                .frame(height: 40)
        }
    }
}

struct NSTextViewWrapper: NSViewRepresentable {
    @Binding var text: String

    func makeNSView(context: Context) -> NSScrollView {
        let scrollView = NSTextView.scrollableTextView()
        let textView = scrollView.documentView as! NSTextView

        textView.delegate = context.coordinator
        textView.backgroundColor = NSColor.clear
        textView.isEditable = true
        textView.isSelectable = true
        textView.drawsBackground = false
        textView.font = NSFont.monospacedSystemFont(ofSize: 13, weight: .regular)
        textView.textColor = NSColor.white
        textView.isRichText = false
        textView.usesFontPanel = false
        textView.allowsUndo = true
        textView.textContainerInset = NSSize(width: 0, height: 10)
        textView.isAutomaticQuoteSubstitutionEnabled = false
        textView.isAutomaticDashSubstitutionEnabled = false
        textView.isAutomaticLinkDetectionEnabled = false
        textView.smartInsertDeleteEnabled = false
        textView.isContinuousSpellCheckingEnabled = false

        // Disable scrolling indicators
        scrollView.hasVerticalScroller = false
        scrollView.hasHorizontalScroller = false
        scrollView.autohidesScrollers = true

        return scrollView
    }

    func updateNSView(_ nsView: NSScrollView, context: Context) {
        let textView = nsView.documentView as! NSTextView
        if textView.string != text {
            textView.string = text
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, NSTextViewDelegate {
        var parent: NSTextViewWrapper

        init(_ parent: NSTextViewWrapper) {
            self.parent = parent
        }

        func textDidChange(_ notification: Notification) {
            guard let textView = notification.object as? NSTextView else { return }
            parent.text = textView.string
        }
    }
}

#Preview {
    ZStack {
        Color(.darkGray)
        GrowingTextField(text: .constant(""), placeholder: "Ask anything")
            .frame(width: 300)
            .padding()
    }
    .frame(width: 350, height: 100)
}
