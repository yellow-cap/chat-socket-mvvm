import Foundation

class ChatViewModel: ObservableObject {
    @Published var messages: [String] = []

    func startChatSession() {
        guard let chatService = F.getWithCallbacks(
                type: IChatService.self,
                onSuccess: onMessageReceived,
                onError: onError) else {

            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.startSession()
    }

    func stopChatSession() {
        guard let chatService = F.getWithCallbacks(
                type: IChatService.self,
                onSuccess: onMessageReceived,
                onError: onError) else {

            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.stopSession()
    }

    func joinChat(userName: String) {
        guard let chatService = F.getWithCallbacks(
                type: IChatService.self,
                onSuccess: onMessageReceived,
                onError: onError) else {

            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.joinChat(userName: userName)
    }

    private func onMessageReceived(message: Message) {
        print("<<<DEV>>> \(message.message)")
        messages.append(message.message)
    }

    private func onError(error: String) {
        print("<<<DEV>>> \(error)")
    }
}
