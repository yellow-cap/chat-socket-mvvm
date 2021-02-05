import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []

    func startChatSession() {}

    func stopChatSession() {}
}
