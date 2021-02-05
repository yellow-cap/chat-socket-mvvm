import SwiftUI

struct ChatContainerProps {
    let userName: String
}

struct ChatContainer: View {
    let props: ChatContainerProps

    var body: some View {
        ChatView(props: ChatViewProps(
                userName: props.userName
        ))
    }
}
