import Foundation
import Combine

protocol IChatViewModel {
    func startChatSession(userName: String)
    func stopChatSession()
    func send(message: String)
    func cleanError()
}

class ChatViewModel: IChatViewModel, ObservableObject {
    @Published var messages: [Message] = []
    @Published var error: String = ""

    func startChatSession(userName: String) {
        guard let chatService = F.getWithCallbacks(
                type: IChatService.self,
                onSuccess: onMessageReceived,
                onError: onError) else {

            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.startSession(userName: userName)
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

    func send(message: String) {
        guard let chatService = F.getWithCallbacks(
                type: IChatService.self,
                onSuccess: onMessageReceived,
                onError: onError) else {

            print("<<<DEV>>> chatService is not exist")

            return
        }

        chatService.send(message: message)
    }


    func cleanError() {
        error = ""
    }

    private func onMessageReceived(message: Message) {
        print("<<<DEV>>> \(message.message)")
        messages.append(message)
    }

    private func onError(err: String) {
        error = err
    }
}
