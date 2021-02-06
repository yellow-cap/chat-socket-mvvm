import SwiftUI

struct ChatContainerProps {
    let userName: String
}

struct ChatContainer: View {
    let props: ChatContainerProps
    @ObservedObject var chatViewModel = F.get(type: IChatViewModel.self) as! ChatViewModel

    var body: some View {
        ChatView(props: ChatViewProps(
                userName: props.userName,
                messages: chatViewModel.messages
        ))
                .onAppear {
                    chatViewModel.startChatSession()
                    chatViewModel.joinChat(userName: props.userName)
                }
                .onDisappear {
                    chatViewModel.stopChatSession()
                }
    }
}
