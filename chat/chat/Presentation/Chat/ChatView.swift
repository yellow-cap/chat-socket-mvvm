import SwiftUI

struct ChatViewProps {
    let userName: String
}

struct ChatView: View {
    let props: ChatViewProps

    var body: some View {
        Text("Hello, \(props.userName)")
                .navigationBarTitle("Chat", displayMode: .inline)
    }
}