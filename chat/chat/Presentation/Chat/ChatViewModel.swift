import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []

    func startChatSession() {
        guard let chatService = F.get(type: IChatService.self) else {
            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.startSession()
    }

    func stopChatSession() {
        guard let chatService = F.get(type: IChatService.self) else {
            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.stopSession()
    }

    func joinChat(userName: String) {
        guard let chatService = F.get(type: IChatService.self) else {
            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.joinChat(userName: userName)
    }
}
