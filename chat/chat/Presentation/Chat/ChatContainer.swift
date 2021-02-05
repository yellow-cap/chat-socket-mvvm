import SwiftUI

struct ChatContainerProps {
    let userName: String
}

struct ChatContainer: View {
    let props: ChatContainerProps
    let chatViewModel = ChatViewModel()

    var body: some View {
        ChatView(props: ChatViewProps(
                userName: props.userName
        ))
                .onAppear {
                    chatViewModel.startChatSession()
                }
                .onDisappear {
                    chatViewModel.stopChatSession()
                }
    }
}
