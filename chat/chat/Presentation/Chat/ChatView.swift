import SwiftUI

struct ChatViewProps {
    let userName: String
    let messages: [Message]
}

struct ChatView: View {
    let props: ChatViewProps

    var body: some View {
        ScrollView {
            ForEach(props.messages, id:\.self) { message in
                Text(message.message)
            }
        }
                .navigationBarTitle("Chat", displayMode: .inline)
    }
}