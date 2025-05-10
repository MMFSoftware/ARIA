import SwiftUI
import AppKit

// MARK: - Service Protocol & Implementation
protocol ChatBotServiceProtocol {
    func process(image: NSImage, prompt: String) async -> String
    func batchProcess(images: [NSImage], prompt: String) async -> [String]
}

class MockChatBotService: ChatBotServiceProtocol {
    private let allResponses = [
        "The vibrant colors in this image create a stunning visual contrast. The warm tones particularly stand out against the cooler background elements.",
        "I notice the muted color palette gives this image a timeless quality. The subtle gradients add depth without overwhelming the composition.",
        "The monochromatic style creates a powerful emotional impact. The varying shades add texture and dimension to what might otherwise be flat.",
        "Bold primary colors dominate this image, creating an energetic and playful aesthetic. This style is reminiscent of pop art from the 1960s.",
        "The pastel color scheme evokes a sense of calm and nostalgia. These soft hues work harmoniously together to create visual cohesion.",
        "The high contrast between dark and light elements creates dramatic visual interest. This chiaroscuro effect draws the eye to key focal points.",
        "Earth tones dominate this composition, creating a natural and organic feel. These colors tend to evoke feelings of groundedness and stability.",
        "The complementary color scheme creates a dynamic visual tension. The opposing colors on the color wheel naturally enhance each other's vibrancy.",
        "Cool blues and greens establish a serene atmosphere in this image. This palette often evokes feelings of tranquility and contemplation.",
        "The selective use of bright accent colors against a neutral background creates effective focal points. This technique guides the viewer's attention masterfully."
    ]

    private var availableResponses: [String]
    private let lock = NSLock()

    init() {
        availableResponses = allResponses
    }

    func process(image: NSImage, prompt: String) async -> String {
        do {
            // Simulate network delay - exactly 2 seconds
            try await Task.sleep(nanoseconds: 2_000_000_000)
            return getUniqueResponse()
        } catch {
            return "Error analyzing image."
        }
    }

    func batchProcess(images: [NSImage], prompt: String) async -> [String] {
        var responses: [String] = []

        do {
            try await Task.sleep(nanoseconds: 2_000_000_000)

            for _ in images {
                responses.append(getUniqueResponse())
            }

            return responses
        } catch {
            return Array(repeating: "Error analyzing image.", count: images.count)
        }
    }

    /// Reset the available responses
    private func resetResponses() {
        lock.lock()
        defer { lock.unlock() }
        availableResponses = allResponses
    }

    /// Helper method to get and remove a unique response
    private func getUniqueResponse() -> String {
        lock.lock()
        defer { lock.unlock() }

        if availableResponses.isEmpty {
            availableResponses = allResponses
        }

        let randomIndex = Int.random(in: 0..<availableResponses.count)
        let selectedResponse = availableResponses.remove(at: randomIndex)

        return selectedResponse
    }
}
