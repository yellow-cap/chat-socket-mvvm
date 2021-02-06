import Foundation
import Swinject

class DIContainerBuilder {
    public static func build() -> Container {
        let container = Container()

        container.register(IChatViewModel.self) { _ -> IChatViewModel in
                ChatViewModel()
        }
                .inObjectScope(.container)

        container.register(IChatService.self, factory: { _, onMessageReceived, onError -> IChatService in
            ChatService(onMessageReceived: onMessageReceived, onError: onError)
        })
                .inObjectScope(.container)

        return container
    }
}