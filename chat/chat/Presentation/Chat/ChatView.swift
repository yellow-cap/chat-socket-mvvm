import SwiftUI

struct ChatViewProps {
    let userName: String
    let messages: [Message]
}

struct ChatView: View {
    let props: ChatViewProps
    @State var message = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(props.messages, id:\.self) { message in
                    Text(message.message)
                }
            }
            HStack {
                VStack {
                    TextField("Type something...", text: self.$message)
                            .foregroundColor(Color(red: 0, green: 0, blue: 0))

                }
                        .padding(7)
                        .background(RoundedRectangle(cornerRadius: 8))
                        .foregroundColor(Color(red: 239/255, green: 239/255, blue: 240/255))

                Spacer()

                Button("Send") {
                    if message.isEmpty {
                        return
                    }

                    // send
                }
            }
        }
                .padding(20)
                .navigationBarTitle("Chat", displayMode: .inline)
    }
}