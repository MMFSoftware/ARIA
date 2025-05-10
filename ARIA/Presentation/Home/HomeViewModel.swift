import SwiftUI

@MainActor
class HomeViewModel: ObservableObject {
    @Published var appTitle = "A.R.I.A."
    @Published var appSubtitle = "AI Review for Image Analysis"
    @Published var messageText = ""
    @Published var selectedImages: [NSImage] = []
    @Published var showErrorAlert = false
    @Published var errorMessage = ""
    @Published var showImageRequiredError = false
    @Published var imageResponses: [ImageResponse] = []
    @Published var showResults = false

    private let chatBotService: ChatBotServiceProtocol

    init(chatBotService: ChatBotServiceProtocol = MockChatBotService()) {
        self.chatBotService = chatBotService
    }

    var isInputEmpty: Bool {
        return messageText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    func sendMessage() {
        guard !isInputEmpty else { return }

        if selectedImages.isEmpty {
            showImageRequiredError = false
            Task { @MainActor in
                self.showImageRequiredError = true
            }
            return
        }

        imageResponses = selectedImages.map { image in
            ImageResponse(image: image, prompt: messageText, response: "", isTyping: true)
        }

        showResults = true
        showImageRequiredError = false

        Task {
            let responses = await chatBotService.batchProcess(
                images: selectedImages,
                prompt: messageText
            )

            await MainActor.run {
                for (index, responseText) in responses.enumerated() {
                    if index < self.imageResponses.count {
                        var updatedResponse = self.imageResponses[index]
                        updatedResponse.response = responseText
                        updatedResponse.isTyping = false
                        self.imageResponses[index] = updatedResponse
                    }
                }
            }
        }
    }

    func addImages() {
        let openPanel = NSOpenPanel()
        openPanel.prompt = "Select Images"
        openPanel.allowsMultipleSelection = true
        openPanel.canChooseDirectories = false
        openPanel.canCreateDirectories = false
        openPanel.canChooseFiles = true
        openPanel.allowedContentTypes = [.image]

        guard openPanel.runModal() == .OK else { return }

        for url in openPanel.urls {
            if let image = NSImage(contentsOf: url) {
                if selectedImages.count < 4 {
                    selectedImages.append(image)
                    showImageRequiredError = false
                } else {
                    showError("Maximum of 4 images allowed.")
                    break
                }
            } else {
                showError("Invalid image format at \(url.lastPathComponent)")
            }
        }
    }

    func removeImage(at index: Int) {
        guard index >= 0 && index < selectedImages.count else { return }
        selectedImages.remove(at: index)
    }

    func showError(_ message: String) {
        errorMessage = message
        showErrorAlert = true
    }

    func resetChat() {
        messageText = ""
        imageResponses = []
        showResults = false
    }
}
