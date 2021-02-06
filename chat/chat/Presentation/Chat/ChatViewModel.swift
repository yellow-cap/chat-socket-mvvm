import Foundation
import Combine

protocol IChatViewModel {
    func startChatSession()
    func stopChatSession()
    func joinChat(userName: String)
}

class ChatViewModel: IChatViewModel, ObservableObject {
    @Published var messages: [Message] = []

    init() {
        print("<<<DEV>>> Init chatViewModel")
    }

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
        messages.append(message)
    }

    private func onError(error: String) {
        print("<<<DEV>>> \(error)")
    }

    deinit {
        print("<<<DEV>>> Deinit chatViewModel")
    }
}
