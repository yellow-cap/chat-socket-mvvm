import SwiftUI

struct ChatView: View {
    let userName: String
    @ObservedObject var chatViewModel = F.get(type: IChatViewModel.self) as! ChatViewModel
    @State var message = ""

    var body: some View {
        VStack {
            ScrollView {
                ForEach(chatViewModel.messages, id:\.self) { message in
                    if message.messageType == MessageType.join {
                        joinMessage(message: message)
                    } else {
                        userMessage(message: message)
                    }
                }
            }

            messageTextField()
        }
                .padding(20)
                .navigationBarTitle("Chat", displayMode: .inline)
                .onAppear {
                    chatViewModel.startChatSession()
                    chatViewModel.joinChat(userName: userName)
                }
                .onDisappear {
                    chatViewModel.stopChatSession()
                }
    }

    private func joinMessage(message: Message) -> some View {
        VStack(spacing: 0) {
            Text(message.message)
                    .font(Font.caption)
                    .foregroundColor(Color.black)
        }
                .frame(height: 16)
                .padding(8)
                .background(RoundedRectangle(cornerRadius: 16))
                .foregroundColor(Color.gray)
    }

    private func userMessage(message: Message) -> some View {
        if message.userName == userName {
            return VStack(spacing: 0) {
                Text(message.message)
                        .foregroundColor(Color.white)
            }
                    .frame(height: 20)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(Color.green)
        } else {
            return VStack(spacing: 0) {
                Text(message.message)
                        .foregroundColor(Color.white)
            }
                    .frame(height: 20)
                    .padding(10)
                    .background(RoundedRectangle(cornerRadius: 20))
                    .foregroundColor(Color.green)
        }
    }

    private func messageTextField() -> some View {
        HStack {
            VStack {
                TextField("Type something...", text: self.$message)
                        .foregroundColor(Color.black)

            }
                    .padding(7)
                    .background(RoundedRectangle(cornerRadius: 8))
                    .foregroundColor(Color.gray)

            Spacer()

            Button("Send") {
                if message.isEmpty {
                    return
                }

                chatViewModel.send(message: message)
                message = ""
            }
        }
    }
}