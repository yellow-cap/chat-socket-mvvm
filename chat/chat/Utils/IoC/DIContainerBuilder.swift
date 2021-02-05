import Foundation
import Swinject

class DIContainerBuilder {
    public static func build() -> Container {
        let container = Container()

        container.register(IChatService.self, factory: { _ -> IChatService in
            ChatService(onMessageReceived: nil, onError: nil)
        })
                .inObjectScope(.container)

        return container
    }
}